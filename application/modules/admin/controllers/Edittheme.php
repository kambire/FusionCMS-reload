<?php

use MX\MX_Controller;

class EditTheme extends MX_Controller
{
    private $theme;
    private $manifest;
    private $configs;

    private function isDebug(): bool
    {
        try {
            return (defined('ENVIRONMENT') && ENVIRONMENT === 'development')
                && $this->input
                && (bool) $this->input->get('debug');
        } catch (Throwable) {
            return false;
        }
    }

    private function debugDie(Throwable $e, string $context): void
    {
        if (function_exists('log_message')) {
            log_message('error', "[admin/edittheme] {$context}: {$e->getMessage()}\n{$e->getTraceAsString()}");
        }

        if ($this->isDebug()) {
            header('Content-Type: text/plain; charset=UTF-8');
            echo "[admin/edittheme] {$context}\n\n";
            echo (string) $e;
            exit;
        }

        throw $e;
    }

    public function __construct()
    {
        parent::__construct();

        // Make sure to load the administrator library!
        $this->load->library('administrator');

        requirePermission("editModuleConfigs");

        require_once(APPPATH . 'libraries/ConfigEditor.php');
    }

    /**
     * Output the configs
     *
     * @param String $theme
     */
    public function index($theme = false)
    {
        try {
            // Make sure the theme exists and has configs
            if (!$theme) {
                $theme = $this->config->item('theme');
            }

            if (!file_exists("application/themes/" . $theme . "/") || !$this->hasConfigs($theme)) {
                if ($this->isDebug()) {
                    header('Content-Type: text/plain; charset=UTF-8');
                    echo "Theme not found or has no configs: " . (string) $theme;
                    exit;
                }
                die();
            }

            $this->theme = $theme;

            $this->loadTheme();
            $this->loadConfigs();

            // Change the title
            $this->administrator->setTitle($this->manifest['name']);

            $data = [
                "configs" => $this->configs,
                "themeName" => $theme,
                "url" => $this->template->page_url
            ];

            // Load my view
            $output = $this->template->loadPage("config_theme.tpl", $data);

            // Put my view in the main box with a headline
            $content = $this->administrator->box('<a href="' . $this->template->page_url . 'admin/theme">Theme</a> &rarr; Edit Config ' . $this->manifest['name'], $output);

            // Output my content. The method accepts the same arguments as template->view
            $this->administrator->view($content, false, "modules/admin/js/settings.js");
        } catch (Throwable $e) {
            $this->debugDie($e, 'index');
        }
    }

    /**
     * Load the theme manifest
     */
    private function loadTheme()
    {
        $this->manifest = @file_get_contents("application/themes/" . $this->theme . "/manifest.json");

        if (!$this->manifest) {
            die("The theme <b>" . $this->theme . "</b> is missing manifest.json");
        } else {
            $this->manifest = json_decode($this->manifest, true);

            // Add the theme folder name as name if none was specified
            if (!array_key_exists("name", $this->manifest)) {
                $this->manifest['name'] = ucfirst($this->theme);
            }
        }
    }

    /**
     * Load the theme configs
     */
    private function loadConfigs()
    {
        foreach (glob("application/themes/" . $this->theme . "/config/*") as $file) {
            if ($file == 'application/themes/' . $this->theme . '/config/template_vars.php' || $file == 'application/themes/' . $this->theme . '/config/base.php' ||
			    $file == 'application/themes/' . $this->theme . '/config/template_assets.php' || $file == 'application/themes/' . $this->theme . '/config/template_functions.php')
                continue;

            $this->getConfig($file);
        }
    }

    /**
     * Load the config into the function variable scope and assign it to the configs array
     */
    private function getConfig($file)
    {
        $comments = [];

        $fileContent = file($file);

        foreach ($fileContent as $line) {
            if (preg_match('/^\s*\$config\s*\[\s*[\'"](.+?)[\'"]\s*\]\s*=.*?;\s*\/\/\s*(.+)$/', $line, $matches)) {
                $comments[$matches[1]] = trim($matches[2]);
            }
        }

        include($file);

        // Skip! don't list this file
        if (isset($config) && isset($config['force_hidden']) && $config['force_hidden'])
            return;

        $name = $this->getConfigName($file);
        $this->configs[$name] = $config;
        $this->configs[$name]['source'] = $this->getConfigSource($file);

        // load comments
        foreach ($comments as $key => $comment) {
            $this->configs[$name]['__comments'][$key] = $comment;
        }
    }

    private function getConfigSource($file)
    {
        $handle = fopen($file, "r");
        $data = fread($handle, filesize($file));
        fclose($handle);

        return $data;
    }

    /**
     * Get the config name out of the path
     *
     * @param  String $path
     * @return String
     */
    private function getConfigName($path = "")
    {
        return preg_replace("/application\/themes\/" . $this->theme . "\/config\/([A-Za-z0-9_-]*)\.php/", "$1", $path);
    }

    public function save($theme = false, $name = false)
    {
        try {
            if (!$name || !$theme || !$this->configExists($theme, $name)) {
                die("Invalid theme or config name");
            } else {
                if ($this->input->post()) {
                    $fusionConfig = new ConfigEditor("application/themes/" . $theme . "/config/" . $name . ".php");

                    foreach ($this->input->post() as $key => $value) {
                        $fusionConfig->set($key, $value);
                    }

                    $fusionConfig->save();

                    die("yes");
                } else {
                    die("No data to set");
                }
            }
        } catch (Throwable $e) {
            $this->debugDie($e, 'save');
        }
    }

    public function saveSource($theme = false, $name = false)
    {
        try {
            if (!$name || !$theme || !$this->configExists($theme, $name)) {
                die("Invalid theme or config name");
            } else {
                if ($this->input->post("source")) {
                    $file = fopen("application/themes/" . $theme . "/config/" . $name . ".php", "w");
                    fwrite($file, $this->input->post("source"));
                    fclose($file);

                    $file = file("application/themes/" . $theme . "/config/" . $name . ".php");
                    $file[0] = str_replace("&lt;", "<", $file[0]);
                    file_put_contents("application/themes/" . $theme . "/config/" . $name . ".php", $file);

                    die("yes");
                } else {
                    die("No data to set");
                }
            }
        } catch (Throwable $e) {
            $this->debugDie($e, 'saveSource');
        }
    }

    private function configExists($theme, $file)
    {
        if (file_exists("application/themes/" . $theme . "/config/" . $file . ".php")) {
            return true;
        } else {
            return false;
        }
    }

    public function hasConfigs($theme)
    {
        if (file_exists("application/themes/" . $theme . "/config")) {
            return true;
        } else {
            return false;
        }
    }
}
