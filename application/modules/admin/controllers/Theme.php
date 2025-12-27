<?php

use MX\MX_Controller;

class Theme extends MX_Controller
{
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
        // Always log the full exception.
        if (function_exists('log_message')) {
            log_message('error', "[admin/theme] {$context}: {$e->getMessage()}\n{$e->getTraceAsString()}");
        }

        if ($this->isDebug()) {
            header('Content-Type: text/plain; charset=UTF-8');
            echo "[admin/theme] {$context}\n\n";
            echo (string) $e;
            exit;
        }

        // Keep existing UX for non-debug.
        throw $e;
    }

    public function __construct()
    {
        parent::__construct();

        // Make sure to load the administrator library!
        $this->load->library('administrator');

        require_once(APPPATH . 'libraries/ConfigEditor.php');

        requirePermission("changeTheme");
    }

    public function index()
    {
        try {
            // Change the title
            $this->administrator->setTitle("Select theme");

            // Prepare my data
            $data = array(
                'url' => $this->template->page_url,
                'themes' => $this->getThemes(),
                'current_theme' => $this->config->item('theme')
            );

            // Load my view
            $output = $this->template->loadPage("theme.tpl", $data);

            // Put my view in the main box with a headline
            $content = $this->administrator->box('Select theme', $output);

            // Output my content. The method accepts the same arguments as template->view
            $this->administrator->view($content, "modules/admin/css/theme.css", "modules/admin/js/theme.js");
        } catch (Throwable $e) {
            $this->debugDie($e, 'index');
        }
    }

    private function getThemes()
    {
        $themes = glob("application/themes/*");
        $themesArr = array();

        foreach ($themes as $value) {
            $value = preg_replace("/application\/themes\/([A-Za-z_-]*)/", "$1", $value);

            //Check if folder
            if (!is_dir("application/themes/" . $value)) {
                continue;
            }

            if (file_exists("application/themes/" . $value . "/manifest.json")) {
                $manifest = json_decode(file_get_contents("application/themes/" . $value . "/manifest.json"), true);
                $manifest['folderName'] = $value;

				// Check if the module has any configs
				if ($this->hasConfigs($value)) {
					$manifest['has_configs'] = true;
				} else {
					$manifest['has_configs'] = false;
				}

                $themesArr[] = $manifest;
            }
        }

        return $themesArr;
    }

    public function hasConfigs($theme)
    {
        if (file_exists("application/themes/" . $theme . "/config")) {
            return true;
        } else {
            return false;
        }
    }

    public function set($theme = false)
    {
        try {
            if (!$theme || !file_exists("application/themes/" . $theme)) {
                if ($this->isDebug()) {
                    header('Content-Type: text/plain; charset=UTF-8');
                    echo "Invalid theme: " . (string) $theme;
                    exit;
                }
                die('Invalid theme');
            }

            $fusionConfig = new ConfigEditor("application/config/fusion.php");
            $fusionConfig->set('theme', $theme);
            $fusionConfig->save();

            $this->cache->delete('*.cache');
            $this->cache->delete('search/*.cache');
            $this->cache->delete('minify/*');

            die('yes');
        } catch (Throwable $e) {
            $this->debugDie($e, 'set');
        }
    }
}
