/**
 * @package    Installer
 * @subpackage Language
 * @since      1.0.0
 * @version    1.0.0
 * @author     Ehsan Zare <darksider.legend@gmail.com>
 * @link       https://code-path.com
 * @copyright  (c) 2023 Code-path web developing team
 */

const Language = (() => {
    // THIS object
    const self = {};

    // Language strings
    self.lang = {};

    // User language
    self.userLang = false;

    // Default language
    self.defaultLang = 'en';

    /**
     * Load JSON file (async)
     * @param  string file
     * @return Promise<object|null>
     */
    self.loadJSON = (file) => {
        file = file || false;

        if(!file || typeof(file) !== 'string')
            return Promise.resolve(null);

        return new Promise((resolve) => {
            const xObj = new XMLHttpRequest();
            xObj.overrideMimeType('application/json');

            // Avoid "forever pending" requests on misconfigured servers.
            xObj.timeout = 15000;

            xObj.onreadystatechange = () => {
                if(xObj.readyState !== 4)
                    return;

                if(xObj.status === 200 && xObj.responseText)
                    resolve(xObj.responseText);
                else
                    resolve(null);
            };

            xObj.ontimeout = () => resolve(null);
            xObj.onerror = () => resolve(null);

            xObj.open('GET', Config.url + 'application/modules/install/languages/' + file + '.json', true);
            xObj.send(null);
        });
    };

    /**
     * Load language file
     * @return void
     */
    self.load = (file) => {
        // Old browsers compatibility
        file = file || false;

        // Missing a parameter or two..
        if(!file)
            return false;

        // Validate parameters
        if(typeof(file) !== 'string')
            return false;

        // Language file is loaded already
        if(typeof self.lang[file] !== 'undefined')
            return Promise.resolve(true);

        // Load language strings
        return self.loadJSON(file).then((response) => {
            if(!response)
                return false;

            try {
                self.lang[file] = JSON.parse(response);
                return true;
            } catch (e) {
                return false;
            }
        });
    };

    /**
     * Get language string
     * @param  string key
     * @param  string lang
     * @return string
     */
    self.get = (key, lang) => {
        // Old browsers compatibility
        key  = key  || false;
        lang = lang || self.defaultLang;

        // Missing a parameter or two..
        if(!key || !lang)
            return false;

        // Validate parameters
        if(typeof(key) !== 'string' || typeof(lang) !== 'string')
            return false;

        // Check if requested key exists
        if(typeof self.lang[lang] !== 'undefined' && typeof self.lang[lang][key] !== 'undefined')
            return self.lang[lang][key];

        // Return key from default language
        if(typeof self.lang[self.defaultLang] !== 'undefined' && typeof self.lang[self.defaultLang][key] !== 'undefined')
            return self.lang[self.defaultLang][key];

        return false;
    };

    /**
     * Initialize actions
     * @return void
     */
    self.init = async () => {
        // English-only installer
        self.userLang = self.defaultLang;

        // Load English then apply replacements once.
        await self.load(self.defaultLang);

        // Replace {{tokens}} in a single pass (much faster than repeated full-body replaceAll).
        const tokenRegex = /\{\{\s*([a-zA-Z0-9_]+)\s*\}\}/g;
        const html = document.body.innerHTML;

        document.body.innerHTML = html.replace(tokenRegex, (match, key) => {
            const value = self.get(String(key), self.userLang);
            return (value !== false && value !== null && value !== undefined) ? String(value) : match;
        });
    };

    return self;
})();
