const Ajax = {
    Requirements: {
        setStatus: function (id, state, text) {
            const el = document.getElementById(id);
            if (!el)
                return;

            el.textContent = text;

            if (state === 'ok') {
                el.style.color = 'green';
            } else if (state === 'error') {
                el.style.color = 'red';
            } else if (state === 'warn') {
                el.style.color = '#e18f00';
            } else {
                el.style.color = '';
            }
        },

        setDetails: function (id, text) {
            const el = document.getElementById(id);
            if (!el)
                return;

            el.textContent = text || '';
        },

        setList: function (id, items) {
            const el = document.getElementById(id);
            if (!el)
                return;

            el.innerHTML = '';

            (items || []).forEach(function (item) {
                const li = document.createElement('li');
                li.textContent = item.text;

                if (item.state === 'ok') {
                    li.style.color = 'green';
                } else if (item.state === 'error') {
                    li.style.color = 'red';
                } else if (item.state === 'warn') {
                    li.style.color = '#e18f00';
                }

                el.appendChild(li);
            });
        }
    },

    initialize: function () {
        $.get("install/next?step=getEmulators", function (data) {
            data = JSON.parse(data);

            $("#emulator").html("");

            $.each(data, function (key, value) {
                $("#emulator").append('<option value=' + key + '>' + value + '</option>');
            });
        });
    },

    Realms: {
        data: [],

        saveAll: function () {
            Ajax.Realms.data = [];
            $("#realm_field form").each(function () {
				const values = {};
				$(this).find("input, select").each(function () {
                    if ($(this).attr("type") != "submit") {
                        values[$(this).attr("id")] = $(this).val();
                    }
                });
                Ajax.Realms.data.push(values);
            })
        },

        addRealm: function (form) {
            UI.confirm('<input id="realmname_preserve" class="nui-focus border-muted-300 text-white placeholder:text-muted-300 dark:border-muted-700 dark:bg-muted-900/75 dark:text-muted-200 dark:placeholder:text-muted-500 dark:focus:border-muted-700 peer w-full border bg-white font-monospace transition-all duration-300 disabled:cursor-not-allowed disabled:opacity-75 px-2 h-10 py-2 text-sm leading-5 pe-4 ps-4 rounded" placeholder="Enter the realm name" autofocus />', 'Add', function () {
				const name = $("#realmname_preserve").val();

				if (!name)
                    return;

                $("#realm_field").append("<div class=\"realmHeader\" data-active=\"true\"><a onclick='Ajax.Realms.show(this);'><img class='realmExtend' src='" + Config.url + "application/modules/install/images/icons/ic_minus.png' /> " + name + "</a> <img class='realmDelete' src='" + Config.url + "application/modules/install/images/icons/ic_delete.png' onclick='Ajax.Realms.deleteRealm(this);' /></div><div class='realmForm'></div>");
                $("#realm_field .realmForm").html($("#loader").html()).find('#realmName').val(name);
                UI.Tooltip.refresh();
            });
        },

        deleteRealm: function (img) {
            UI.confirm('Are you sure?', 'Yes', function () {
                $(img).parents('.realmHeader, .realmHeader + div.realmForm').fadeOut(200, function () {
                    $(img).parent('.realmHeader').next('.realmForm').remove();
                    $(img).parent('.realmHeader').remove();
                    Ajax.Realms.saveAll();
                });
            });
        },

        show: function (anchor) {
			const div = $(anchor).parents('div.realmHeader');

			if (div.attr("data-active") == "true") {
                div.next('.realmForm').slideUp(200, function () {
                    div.find('img.realmExtend').attr('src', Config.url + "application/modules/install/images/icons/ic_plus.png");
                    div.removeAttr("data-active");
                });

                Ajax.Realms.saveAll();
            } else {
                div.next('.realmForm').slideDown(200, function () {
                    div.find('img.realmExtend').attr('src', Config.url + "application/modules/install/images/icons/ic_minus.png");
                    div.attr("data-active", "true");
                });
            }
        }
    },

    checkPhpVersion: function (onComplete) {
        $.get("install/next?step=checkPhpVersion", function (data) {
            if (data == '1')
                $('.php-version .check-result').css('color', 'green').html('OK!');
            else
                $('.php-version .check-result').addClass('error').css('color', 'red').html('Not installed.');

            Ajax.Requirements.setStatus('req_php_version_status', data == '1' ? 'ok' : 'error', data == '1' ? 'OK' : 'Fail');

            if (onComplete !== undefined)
                onComplete(data == '1');
        });
    },

    setAndCheckDbConnection: function (data, onComplete) {
        $.post("install/next?step=setAndCheckDbConnection", data, function (data) {
            if (onComplete !== undefined)
                onComplete(data);
        })
    },

    checkAuthConfig: function (data, onComplete) {
        $.post("install/next?step=checkAuthConfig", data, function (data) {
            if (onComplete !== undefined)
                onComplete(data);
        })
    },

    checkPermissions: function (onComplete) {
		let done = 0;

		if (onComplete !== undefined) {
			const id = setInterval(function () {
				if (done == 6) {
					clearInterval(id);
					onComplete();
				}
			}, 100);
		}

        $.get("install/next?step=folder&test=config&path=application", function (data) {
            if (data == '1') {
                $("#config_folder").css({color: "green"}).removeClass('error').html("/application/config/ is writable");
                Ajax.Requirements.setStatus('req_folder_config_status', 'ok', 'OK');
            } else {
                $("#config_folder").css({color: "red"}).addClass('error').html('/application/config/ needs to be writable (see <a href="http://en.wikipedia.org/wiki/Chmod" target="_blank">chmod</a>)');
                Ajax.Requirements.setStatus('req_folder_config_status', 'error', 'Fail');
            }

            done++;
        });

        $.get("install/next?step=folder&test=modules&path=application", function (data) {
            if (data == '1') {
                $("#modules_folder").css({color: "green"}).removeClass('error').html("/application/modules/ is writable");
                Ajax.Requirements.setStatus('req_folder_modules_status', 'ok', 'OK');
            } else {
                $("#modules_folder").css({color: "red"}).addClass('error').html('/application/modules/ needs to be writable (see <a href="http://en.wikipedia.org/wiki/Chmod" target="_blank">chmod</a>)');
                Ajax.Requirements.setStatus('req_folder_modules_status', 'error', 'Fail');
            }

            done++;
        });

        $.get("install/next?step=folder&test=cache&path=writable", function (data) {
            if (data == '1') {
                $("#cache_folder").css({color: "green"}).removeClass('error').html("/writable/cache/ is writable");
                Ajax.Requirements.setStatus('req_folder_cache_status', 'ok', 'OK');
            } else {
                $("#cache_folder").css({color: "red"}).addClass('error').html('/writable/cache/ needs to be writable (see <a href="http://en.wikipedia.org/wiki/Chmod" target="_blank">chmod</a>)');
                Ajax.Requirements.setStatus('req_folder_cache_status', 'error', 'Fail');
            }

            done++;
        });

        $.get("install/next?step=folder&test=backups&path=writable", function (data) {
            if (data == '1') {
                $("#backups_folder").css({color: "green"}).removeClass('error').html("/writable/backups/ is writable");
                Ajax.Requirements.setStatus('req_folder_backups_status', 'ok', 'OK');
            } else {
                $("#backups_folder").css({color: "red"}).addClass('error').html('/writable/backups/ needs to be writable (see <a href="http://en.wikipedia.org/wiki/Chmod" target="_blank">chmod</a>)');
                Ajax.Requirements.setStatus('req_folder_backups_status', 'error', 'Fail');
            }

            done++;
        });

        $.get("install/next?step=folder&test=logs&path=writable", function (data) {
            if (data == '1') {
                $("#logs_folder").css({color: "green"}).removeClass('error').html("/writable/logs/ is writable");
                Ajax.Requirements.setStatus('req_folder_logs_status', 'ok', 'OK');
            } else {
                $("#logs_folder").css({color: "red"}).addClass('error').html('/writable/logs/ needs to be writable (see <a href="http://en.wikipedia.org/wiki/Chmod" target="_blank">chmod</a>)');
                Ajax.Requirements.setStatus('req_folder_logs_status', 'error', 'Fail');
            }

            done++;
        });

        $.get("install/next?step=folder&test=uploads&path=writable", function (data) {
            if (data == '1') {
                $("#uploads_folder").css({color: "green"}).removeClass('error').html("/writable/uploads/ is writable");
                Ajax.Requirements.setStatus('req_folder_uploads_status', 'ok', 'OK');
            } else {
                $("#uploads_folder").css({color: "red"}).addClass('error').html('/writable/uploads/ needs to be writable (see <a href="http://en.wikipedia.org/wiki/Chmod" target="_blank">chmod</a>)');
                Ajax.Requirements.setStatus('req_folder_uploads_status', 'error', 'Fail');
            }

            done++;
        });
    },

    checkPhpExtensions: function (onComplete) {
        $.get("install/next?step=checkPhpExtensions", function (data) {
            const required = ['mysqli', 'curl', 'openssl', 'soap', 'gd', 'gmp', 'mbstring', 'intl', 'json', 'xml', 'zip'];
            const missing = (data && data !== '1')
                ? data.split(',').map(function (s) { return (s || '').trim(); }).filter(Boolean)
                : [];

            Ajax.Requirements.setList(
                'req_php_extensions_list',
                required.map(function (ext) {
                    const isMissing = missing.indexOf(ext) !== -1;
                    return {
                        text: (isMissing ? '✗ ' : '✓ ') + 'php_' + ext,
                        state: isMissing ? 'error' : 'ok'
                    };
                })
            );

            if (data != '1') {
                $("#php-extensions-missing .extensions").text(data).parent().show();
                $('.php-extensions .check-result').hide();

                Ajax.Requirements.setStatus('req_php_extensions_status', 'error', 'Fail');
                Ajax.Requirements.setDetails('req_php_extensions_details', data);
            } else {
                $('#php-extensions-missing').hide();
                $('.php-extensions .check-result').css('color', 'green').html('OK!').show();

                Ajax.Requirements.setStatus('req_php_extensions_status', 'ok', 'OK');
                Ajax.Requirements.setDetails('req_php_extensions_details', '');
            }

            if (onComplete !== undefined)
                onComplete(data);
        });
    },

    checkApacheModules: function (onComplete) {
        $.get("install/next?step=checkApacheModules", function (data) {
            const required = ['mod_rewrite', 'mod_headers', 'mod_expires', 'mod_deflate', 'mod_filter'];
            const missing = (data && data !== '1' && data !== '2')
                ? data.split(',').map(function (s) { return (s || '').trim(); }).filter(Boolean)
                : [];

            if (data == '2') {
                Ajax.Requirements.setList(
                    'req_apache_modules_list',
                    required.map(function (mod) {
                        return { text: '? ' + mod, state: 'warn' };
                    })
                );
            } else {
                Ajax.Requirements.setList(
                    'req_apache_modules_list',
                    required.map(function (mod) {
                        const isMissing = missing.indexOf(mod) !== -1;
                        return {
                            text: (isMissing ? '✗ ' : '✓ ') + mod,
                            state: isMissing ? 'error' : 'ok'
                        };
                    })
                );
            }

            if (data == '1') {
                $('#apache-modules-missing').hide();
                $('.apache-modules .check-result').css('color', 'green').html('OK!').show();

                Ajax.Requirements.setStatus('req_apache_modules_status', 'ok', 'OK');
                Ajax.Requirements.setDetails('req_apache_modules_details', '');
            } else if (data == '2') {
                $("#apache-modules-missing .modules").text('Unable to check Apache Modules, make sure required modules are enabled.').parent().show();
                $('.apache-modules .check-result').hide();

                Ajax.Requirements.setStatus('req_apache_modules_status', 'warn', 'Unknown');
                Ajax.Requirements.setDetails('req_apache_modules_details', 'Unable to check');
            } else {
                $("#apache-modules-missing .modules").text(data).parent().show();
                $('.apache-modules .check-result').hide();

                Ajax.Requirements.setStatus('req_apache_modules_status', 'error', 'Fail');
                Ajax.Requirements.setDetails('req_apache_modules_details', data);
            }

            if (onComplete !== undefined)
                onComplete(data);
        });
    },

    Install: {

        initialize: function (name) {
            $('#install').text('');

            Ajax.Install.configs(name, function () {
                Ajax.Install.database(function () {
                    Ajax.Install.realms(function () {
                        $.get("install/next?step=final", function (data) {
                            if (data != "success") {
                                UI.alert('Please delete or rename the "install" folder and then visit your site again.');
                            } else {
                                UI.alert('Installation successful', 500);

                                setTimeout(function () {
                                    Memory.clear();

                                    // Display actions
                                    $('#install_after_actions').fadeIn();
                                }, 500);
                            }
                        });
                    });
                });
            });
        },

        complete: function () {
            $("#install").append("<div style='color:green;display:inline;'>done</div><br />");
        },

        configs: function (name, callback) {
            $("#install").append("Writing configs...");

			const data = {
				title: $("#title").val(),
				server_name: $("#server_name").val(),
				realmlist: $("#realmlist").val(),
				max_expansion: $("#max_expansion").val(),
				keywords: $("#keywords").val(),
				description: $("#description").val(),
				analytics: $("#analytics").val(),
				captcha: $("#captcha").val(),
				site_key: $("#site_key").val(),
				secret_key: $("#secret_key").val(),
				cdn: $("#cdn").val(),
                cdn_link: $("#cdn_link").val(),
				security_code: $("#security_code").val(),
				emulator: $("#emulator").val(),
				superadmin: name,

				// Auth config (config/auth.php)
				realmd_rbac: $('#realmd_rbac').val(),
				realmd_battle_net: $('#realmd_battle_net').val(),
				realmd_totp_secret: $('#realmd_totp_secret').val(),
				realmd_totp_secret_name: $('#realmd_totp_secret_name').val(),
				realmd_account_encryption: $('#realmd_account_encryption').val(),
				realmd_battle_net_encryption: $('#realmd_battle_net_encryption').val()
			};

			$.post("install/next?step=config", data, function (res) {
                if (res != '1') {
                    UI.alert("Something went wrong: " + res);
                } else {
                    Ajax.Install.complete();
                    callback();
                }
            });
        },

        database: function (callback) {
            $("#install").append("Importing database...");

            $.post("install/next?step=database", function (res) {
                if (res != '1') {
                    UI.alert("Something went wrong: " + res);
                } else {
                    Ajax.Install.complete();
                    callback();
                }
            });
        },

        realms: function (callback) {
            $("#install").append("Creating realms...");

			const data = {
				realms: JSON.stringify(Ajax.Realms.data),
				emulator: $("#emulator").val()
			};

			$.post("install/next?step=realms", data, function (res) {
                if (res != '1') {
                    UI.alert("Something went wrong: " + res);
                } else {
                    Ajax.Install.complete();
                    callback();
                }
            });
        }
    }
};
