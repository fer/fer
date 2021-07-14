# BB2

## Prework

### Connect to VPN

```bash
sudo openvpn black-box-penetration-test-2.ovpn
```

### Scan network

```bash
sudo nmap -sn 172.16.64.0/24 --exclude 172.16.64.10 -oN hostAlive.nmap &&
cat hostAlive.nmap | grep for | awk {'print $5'} > ips.txt &&
sudo nmap -sV -n -v -Pn -p- -T4 -iL ips.txt -A --open -oX portScan.xml &&
sh nmap2md.sh portScan.xml | xclip
```

## Scanner

> Generated on **Mon Jul 12 18:49:14 2021** with `nmap 7.91`.

```bash
nmap -sV -n -v -Pn -p- -T4 -iL ips.txt -A --open -oX portScan.xml
```

## Hosts Alive \(4\)

| Host | OS | Accuracy |
| :--- | :--- | :--- |
| 172.16.64.81 | Linux 3.16 | 95% |
| 172.16.64.91 | Linux 3.13 | 95% |
| 172.16.64.92 | Linux 3.12 | 95% |
| 172.16.64.166 | Linux 3.12 | 95% |

## Open Ports and Running Services

### 172.16.64.81 \(Linux 3.16 - 95%\)

| Port | State | Service | Version |
| :--- | :--- | :--- | :--- |
| 22/tcp | open | ssh | OpenSSH 7.2p2 Ubuntu 4ubuntu2.8 |
| 80/tcp | open | http | Apache httpd 2.4.18 |
| 13306/tcp | open | mysql | MySQL 5.7.25-0ubuntu0.16.04.2 |

{% tabs %}
{% tab title="Dirbuster" %}
* Target URL: [http://172.16.64.81](http://172.16.64.81)
* File Extension: \*
* File with list of dirs/files: /usr/share/dirbuster/wordlists/directory-list-lowercase-2.3-medium.txt
{% endtab %}

{% tab title="Report" %}
```bash
DirBuster 1.0-RC1 - Report
http://www.owasp.org/index.php/Category:OWASP_DirBuster_Project
Report produced on Mon Jul 12 19:22:08 EDT 2021
--------------------------------

http://172.16.64.81:80
--------------------------------
Directories found during testing:

Dirs found with a 200 response:

/
/webapp/
/default/
/webapp/img/
/webapp/templates/
/webapp/img/custom/
/webapp/img/favicon/
/webapp/templates/default/
/webapp/img/google/
/webapp/img/log_icons/
/webapp/templates/gallery/
/webapp/templates/pinboxes/
/webapp/img/custom/logo/
/webapp/assets/
/webapp/img/custom/thumbs/
/webapp/templates/gallery/font-awesome-4.6.3/
/webapp/templates/default/lang/
/webapp/templates/pinboxes/font-awesome-4.6.3/
/webapp/templates/gallery/img/
/webapp/templates/gallery/lang/
/webapp/templates/pinboxes/img/
/webapp/templates/pinboxes/js/
/webapp/templates/pinboxes/lang/
/webapp/assets/bootstrap/
/webapp/upload/
/webapp/assets/font-awesome/
/webapp/templates/pinboxes/font-awesome-4.6.3/css/
/webapp/upload/files/
/webapp/assets/bootstrap/css/
/webapp/templates/pinboxes/font-awesome-4.6.3/fonts/
/webapp/templates/gallery/font-awesome-4.6.3/css/
/webapp/assets/bootstrap/fonts/
/webapp/assets/font-awesome/css/
/webapp/templates/gallery/font-awesome-4.6.3/fonts/
/webapp/templates/pinboxes/font-awesome-4.6.3/less/
/webapp/templates/pinboxes/font-awesome-4.6.3/scss/
/webapp/templates/gallery/font-awesome-4.6.3/less/
/webapp/assets/font-awesome/fonts/
/webapp/assets/bootstrap/js/
/webapp/templates/gallery/font-awesome-4.6.3/scss/
/webapp/assets/font-awesome/less/
/webapp/assets/font-awesome/scss/
/webapp/css/
/webapp/includes/
/webapp/includes/Google/
/webapp/includes/classes/
/webapp/includes/Google/Oauth2/
/webapp/includes/Google/Oauth2/auth/
/webapp/includes/Google/Oauth2/cache/
/webapp/includes/Google/Oauth2/contrib/
/webapp/includes/Google/Oauth2/external/
/webapp/includes/Google/Oauth2/io/
/webapp/includes/js/
/webapp/includes/Google/Oauth2/service/
/webapp/install/
/webapp/includes/phpass/
/webapp/includes/js/bootstrap-datepicker/
/webapp/includes/js/bootstrap-spinedit/
/webapp/includes/phpmailer/
/webapp/includes/plupload/
/webapp/includes/js/bootstrap-toggle/
/webapp/includes/random_compat/
/webapp/includes/js/chosen/
/webapp/includes/phpass/c/
/webapp/includes/js/ckeditor/
/webapp/includes/plupload/js/
/webapp/includes/js/bootstrap-toggle/doc/
/webapp/includes/js/flot/
/webapp/includes/js/bootstrap-spinedit/css/
/webapp/includes/js/footable/
/webapp/includes/js/bootstrap-spinedit/js/
/webapp/includes/js/chosen/docsupport/
/webapp/includes/js/bootstrap-datepicker/css/
/webapp/includes/js/bootstrap-toggle/js/
/webapp/includes/js/footable/css/
/webapp/includes/plupload/js/i18n/
/webapp/includes/js/jen/
/webapp/includes/js/bootstrap-datepicker/js/
/webapp/includes/js/footable/css/fonts/
/webapp/includes/js/ckeditor/adapters/
/webapp/includes/js/jquery-tags-input/
/webapp/includes/plupload/js/jquery.plupload.queue/
/webapp/includes/plupload/js/jquery.plupload.queue/css/
/webapp/includes/plupload/js/jquery.plupload.queue/img/
/webapp/includes/js/bootstrap-datepicker/js/locales/
/webapp/includes/js/ckeditor/lang/
/webapp/includes/js/ckeditor/plugins/
/webapp/includes/timthumb/
/webapp/includes/js/jen/bin/
/webapp/includes/js/ckeditor/skins/
/webapp/includes/timthumb/cache/
/webapp/includes/js/ckeditor/plugins/about/
/webapp/includes/js/ckeditor/plugins/clipboard/
/webapp/includes/js/ckeditor/skins/moono-lisa/
/webapp/includes/js/ckeditor/plugins/dialog/
/webapp/includes/phpmailer/extras/
/webapp/includes/js/ckeditor/plugins/about/dialogs/
/webapp/includes/widgets/
/webapp/includes/js/ckeditor/plugins/link/
/webapp/includes/js/ckeditor/plugins/clipboard/dialogs/
/webapp/includes/phpmailer/language/
/webapp/includes/js/ckeditor/plugins/link/images/
/webapp/includes/js/ckeditor/skins/moono-lisa/images/
/webapp/includes/js/ckeditor/plugins/link/dialogs/
/webapp/includes/js/ckeditor/plugins/link/images/hidpi/
/webapp/includes/js/ckeditor/plugins/about/dialogs/hidpi/
/webapp/includes/js/ckeditor/skins/moono-lisa/images/hidpi/
/webapp/lang/
/webapp/includes/js/bootstrap-toggle/css/

Dirs found with a 403 response:

/icons/
/icons/small/


--------------------------------
Files found during testing:

Files found with a 302 responce:

/webapp/process.php
/webapp/templates/session_check.php
/webapp/includes/actions.log.export.php

Files found with a 200 responce:

/webapp/img/ps-icon.svg
/webapp/templates/default/main.css
/webapp/templates/gallery/main.css
/webapp/templates/pinboxes/lang/en.mo
/webapp/templates/pinboxes/js/imagesloaded.pkgd.min.js
/webapp/templates/gallery/lang/en.mo
/webapp/templates/pinboxes/font-awesome-4.6.3/HELP-US-OUT.txt
/webapp/templates/default/lang/default.pot
/webapp/templates/pinboxes/main.css
/webapp/templates/gallery/font-awesome-4.6.3/HELP-US-OUT.txt
/webapp/img/custom/thumbs/users.bak
/webapp/templates/gallery/lang/en.po
/webapp/templates/pinboxes/main.css.map
/webapp/templates/default/lang/en.mo
/webapp/templates/pinboxes/js/jquery.masonry.min.js
/webapp/assets/bootstrap/config.json
/webapp/templates/default/lang/en.po
/webapp/templates/pinboxes/lang/en.po
/webapp/templates/pinboxes/main.scss
/webapp/templates/gallery/lang/gallery.pot
/webapp/assets/font-awesome/HELP-US-OUT.txt
/webapp/templates/pinboxes/lang/pinboxes.pot
/webapp/templates/pinboxes/font-awesome-4.6.3/css/font-awesome.css
/webapp/templates/pinboxes/font-awesome-4.6.3/css/font-awesome.min.css
/webapp/templates/gallery/font-awesome-4.6.3/css/font-awesome.css
/webapp/templates/pinboxes/font-awesome-4.6.3/fonts/FontAwesome.otf
/webapp/assets/bootstrap/css/bootstrap-theme.css
/webapp/templates/gallery/font-awesome-4.6.3/fonts/FontAwesome.otf
/webapp/assets/font-awesome/css/font-awesome.css
/webapp/templates/pinboxes/font-awesome-4.6.3/fonts/fontawesome-webfont.eot
/webapp/templates/gallery/font-awesome-4.6.3/css/font-awesome.min.css
/webapp/assets/bootstrap/fonts/glyphicons-halflings-regular.eot
/webapp/templates/gallery/font-awesome-4.6.3/scss/_animated.scss
/webapp/assets/font-awesome/less/animated.less
/webapp/assets/bootstrap/js/bootstrap.js
/webapp/assets/bootstrap/fonts/glyphicons-halflings-regular.svg
/webapp/assets/font-awesome/css/font-awesome.min.css
/webapp/templates/pinboxes/font-awesome-4.6.3/fonts/fontawesome-webfont.svg
/webapp/templates/gallery/font-awesome-4.6.3/less/animated.less
/webapp/assets/font-awesome/fonts/FontAwesome.otf
/webapp/templates/pinboxes/font-awesome-4.6.3/scss/_animated.scss
/webapp/templates/gallery/font-awesome-4.6.3/fonts/fontawesome-webfont.eot
/webapp/assets/bootstrap/css/bootstrap-theme.css.map
/webapp/templates/pinboxes/font-awesome-4.6.3/less/animated.less
/webapp/templates/pinboxes/font-awesome-4.6.3/scss/_bordered-pulled.scss
/webapp/templates/gallery/font-awesome-4.6.3/less/bordered-pulled.less
/webapp/assets/bootstrap/css/bootstrap-theme.min.css
/webapp/assets/font-awesome/fonts/fontawesome-webfont.eot
/webapp/templates/gallery/font-awesome-4.6.3/scss/_bordered-pulled.scss
/webapp/assets/bootstrap/js/bootstrap.min.js
/webapp/assets/font-awesome/less/bordered-pulled.less
/webapp/templates/gallery/font-awesome-4.6.3/fonts/fontawesome-webfont.svg
/webapp/templates/pinboxes/font-awesome-4.6.3/fonts/fontawesome-webfont.ttf
/webapp/assets/font-awesome/scss/_animated.scss
/webapp/assets/bootstrap/js/npm.js
/webapp/assets/bootstrap/fonts/glyphicons-halflings-regular.ttf
/webapp/templates/gallery/font-awesome-4.6.3/less/core.less
/webapp/templates/pinboxes/font-awesome-4.6.3/fonts/fontawesome-webfont.woff
/webapp/templates/pinboxes/font-awesome-4.6.3/scss/_core.scss
/webapp/assets/font-awesome/less/core.less
/webapp/templates/pinboxes/font-awesome-4.6.3/less/bordered-pulled.less
/webapp/assets/bootstrap/css/bootstrap-theme.min.css.map
/webapp/assets/font-awesome/scss/_bordered-pulled.scss
/webapp/templates/gallery/font-awesome-4.6.3/fonts/fontawesome-webfont.ttf
/webapp/templates/gallery/font-awesome-4.6.3/scss/_core.scss
/webapp/templates/pinboxes/font-awesome-4.6.3/less/core.less
/webapp/assets/font-awesome/less/fixed-width.less
/webapp/templates/pinboxes/font-awesome-4.6.3/scss/_fixed-width.scss
/webapp/assets/bootstrap/fonts/glyphicons-halflings-regular.woff
/webapp/templates/pinboxes/font-awesome-4.6.3/fonts/fontawesome-webfont.woff2
/webapp/assets/font-awesome/scss/_core.scss
/webapp/templates/gallery/font-awesome-4.6.3/less/fixed-width.less
/webapp/templates/gallery/font-awesome-4.6.3/scss/_fixed-width.scss
/webapp/templates/pinboxes/font-awesome-4.6.3/less/fixed-width.less
/webapp/templates/pinboxes/font-awesome-4.6.3/scss/_icons.scss
/webapp/assets/font-awesome/less/font-awesome.less
/webapp/assets/bootstrap/css/bootstrap.css
/webapp/assets/font-awesome/scss/_fixed-width.scss
/webapp/templates/gallery/font-awesome-4.6.3/fonts/fontawesome-webfont.woff
/webapp/templates/pinboxes/font-awesome-4.6.3/less/font-awesome.less
/webapp/assets/font-awesome/fonts/fontawesome-webfont.svg
/webapp/templates/gallery/font-awesome-4.6.3/less/font-awesome.less
/webapp/templates/pinboxes/font-awesome-4.6.3/scss/_larger.scss
/webapp/assets/bootstrap/fonts/glyphicons-halflings-regular.woff2
/webapp/templates/gallery/font-awesome-4.6.3/fonts/fontawesome-webfont.woff2
/webapp/assets/font-awesome/less/larger.less
/webapp/templates/gallery/font-awesome-4.6.3/scss/_larger.scss
/webapp/assets/font-awesome/fonts/fontawesome-webfont.ttf
/webapp/assets/font-awesome/fonts/fontawesome-webfont.woff
/webapp/assets/font-awesome/less/icons.less
/webapp/templates/gallery/font-awesome-4.6.3/scss/_icons.scss
/webapp/templates/pinboxes/font-awesome-4.6.3/scss/_list.scss
/webapp/templates/gallery/font-awesome-4.6.3/less/icons.less
/webapp/assets/font-awesome/scss/_icons.scss
/webapp/templates/gallery/font-awesome-4.6.3/scss/_list.scss
/webapp/templates/gallery/font-awesome-4.6.3/less/larger.less
/webapp/assets/font-awesome/scss/_larger.scss
/webapp/templates/pinboxes/font-awesome-4.6.3/scss/_mixins.scss
/webapp/assets/font-awesome/less/list.less
/webapp/assets/bootstrap/css/bootstrap.min.css
/webapp/assets/bootstrap/css/bootstrap.css.map
/webapp/templates/gallery/font-awesome-4.6.3/scss/_mixins.scss
/webapp/assets/font-awesome/less/mixins.less
/webapp/templates/pinboxes/font-awesome-4.6.3/scss/_path.scss
/webapp/assets/bootstrap/css/bootstrap.min.css.map
/webapp/templates/gallery/font-awesome-4.6.3/scss/_path.scss
/webapp/templates/pinboxes/font-awesome-4.6.3/scss/_rotated-flipped.scss
/webapp/assets/font-awesome/less/path.less
/webapp/templates/gallery/font-awesome-4.6.3/less/list.less
/webapp/templates/pinboxes/font-awesome-4.6.3/less/larger.less
/webapp/assets/font-awesome/scss/_list.scss
/webapp/templates/pinboxes/font-awesome-4.6.3/less/icons.less
/webapp/templates/gallery/font-awesome-4.6.3/scss/_rotated-flipped.scss
/webapp/templates/pinboxes/font-awesome-4.6.3/scss/_screen-reader.scss
/webapp/assets/font-awesome/less/rotated-flipped.less
/webapp/assets/font-awesome/scss/_mixins.scss
/webapp/templates/gallery/font-awesome-4.6.3/scss/_screen-reader.scss
/webapp/templates/pinboxes/font-awesome-4.6.3/less/list.less
/webapp/templates/pinboxes/font-awesome-4.6.3/scss/_stacked.scss
/webapp/assets/font-awesome/less/screen-reader.less
/webapp/assets/font-awesome/scss/_path.scss
/webapp/assets/font-awesome/scss/_rotated-flipped.scss
/webapp/assets/font-awesome/less/stacked.less
/webapp/assets/font-awesome/fonts/fontawesome-webfont.woff2
/webapp/templates/pinboxes/font-awesome-4.6.3/less/mixins.less
/webapp/templates/gallery/font-awesome-4.6.3/scss/_stacked.scss
/webapp/templates/pinboxes/font-awesome-4.6.3/scss/_variables.scss
/webapp/assets/font-awesome/scss/_screen-reader.scss
/webapp/templates/pinboxes/font-awesome-4.6.3/less/path.less
/webapp/templates/gallery/font-awesome-4.6.3/less/mixins.less
/webapp/templates/pinboxes/font-awesome-4.6.3/scss/font-awesome.scss
/webapp/assets/font-awesome/less/variables.less
/webapp/templates/gallery/font-awesome-4.6.3/scss/_variables.scss
/webapp/assets/font-awesome/scss/_stacked.scss
/webapp/templates/gallery/font-awesome-4.6.3/scss/font-awesome.scss
/webapp/templates/pinboxes/font-awesome-4.6.3/less/rotated-flipped.less
/webapp/templates/gallery/font-awesome-4.6.3/less/path.less
/webapp/templates/pinboxes/font-awesome-4.6.3/less/screen-reader.less
/webapp/assets/font-awesome/scss/_variables.scss
/webapp/templates/gallery/font-awesome-4.6.3/less/rotated-flipped.less
/webapp/templates/pinboxes/font-awesome-4.6.3/less/stacked.less
/webapp/templates/gallery/font-awesome-4.6.3/less/screen-reader.less
/webapp/templates/pinboxes/font-awesome-4.6.3/less/variables.less
/webapp/assets/font-awesome/scss/font-awesome.scss
/webapp/templates/gallery/font-awesome-4.6.3/less/stacked.less
/webapp/templates/gallery/font-awesome-4.6.3/less/variables.less
/webapp/css/footable.css
/webapp/css/main.css.map
/webapp/css/main.min.css
/webapp/css/mobile.css.map
/webapp/css/main.scss
/webapp/css/mobile.min.css
/webapp/css/mobile.scss
/webapp/css/social-login.css
/webapp/includes/ajax-keep-alive.php
/webapp/includes/email-template.php
/webapp/includes/classes/actions-categories.php
/webapp/includes/functions.categories.php
/webapp/includes/classes/actions-clients.php
/webapp/includes/Google/Oauth2/Google_Client.php
/webapp/includes/classes/actions-files.php
/webapp/includes/functions.forms.php
/webapp/includes/functions.php
/webapp/includes/classes/actions-groups.php
/webapp/includes/Google/Oauth2/config.php
/webapp/includes/functions.templates.php
/webapp/includes/classes/actions-members.php
/webapp/includes/classes/actions-users.php
/webapp/includes/Google/Oauth2/auth/Google_AssertionCredentials.php
/webapp/includes/classes/database.php
/webapp/includes/language-locales-names.php
/webapp/includes/classes/file-upload.php
/webapp/includes/Google/Oauth2/cache/Google_Cache.php
/webapp/includes/Google/Oauth2/io/Google_CacheParser.php
/webapp/includes/Google/Oauth2/service/Google_BatchRequest.php
/webapp/includes/Google/Oauth2/auth/Google_LoginTicket.php
/webapp/includes/Google/Oauth2/external/URITemplateParser.php
/webapp/includes/classes/generate-form.php
/webapp/includes/classes/generate-table.php
/webapp/includes/Google/Oauth2/io/Google_HttpRequest.php
/webapp/includes/Google/Oauth2/service/Google_MediaFileUpload.php
/webapp/includes/classes/i18n.php
/webapp/includes/Google/Oauth2/service/Google_Model.php
/webapp/includes/Google/Oauth2/service/Google_Service.php
/webapp/includes/js/browserplus-min.js
/webapp/includes/Google/Oauth2/service/Google_ServiceResource.php
/webapp/includes/Google/Oauth2/auth/Google_Signer.php
/webapp/includes/js/bootstrap-spinedit/LICENSE.txt
/webapp/includes/phpass/PasswordHash.php
/webapp/includes/Google/Oauth2/io/Google_REST.php
/webapp/includes/js/bootstrap-datepicker/CHANGELOG.md
/webapp/includes/sys.config.php
/webapp/includes/phpmailer/LICENSE
/webapp/includes/Google/Oauth2/service/Google_Utils.php
/webapp/includes/plupload/changelog.txt
/webapp/includes/js/bootstrap-spinedit/README.md
/webapp/includes/js/chosen/options.html
/webapp/includes/js/bootstrap-datepicker/CONTRIBUTING.md
/webapp/includes/Google/Oauth2/auth/Google_Verifier.php
/webapp/includes/phpmailer/PHPMailerAutoload.php
/webapp/includes/random_compat/random_compat.phar
/webapp/includes/Google/Oauth2/io/cacerts.pem
/webapp/includes/js/bootstrap-datepicker/LICENSE
/webapp/includes/plupload/license.txt
/webapp/includes/phpmailer/VERSION
/webapp/includes/js/chosen/index.proto.html
/webapp/includes/js/bootstrap-toggle/doc/nytdev.svg
/webapp/includes/sys.config.sample.php
/webapp/includes/random_compat/random_compat.phar.pubkey
/webapp/includes/js/bootstrap-toggle/doc/script.js
/webapp/includes/js/ckeditor/CHANGES.md
/webapp/includes/js/bootstrap-datepicker/README.md
/webapp/includes/js/chosen/chosen.jquery.js
/webapp/includes/phpass/c/Makefile
/webapp/includes/js/chosen/docsupport/prism.js
/webapp/includes/plupload/readme.md
/webapp/includes/phpmailer/class.phpmailer.php
/webapp/includes/random_compat/random_compat.phar.pubkey.asc
/webapp/includes/js/ckeditor/LICENSE.md
/webapp/includes/js/bootstrap-spinedit/css/bootstrap-spinedit.css
/webapp/includes/js/bootstrap-spinedit/js/bootstrap-spinedit.js
/webapp/includes/js/html5shiv.min.js
/webapp/includes/js/footable/footable.all.min.js
/webapp/includes/js/bootstrap-toggle/doc/stylesheet.css
/webapp/includes/js/ckeditor/README.md
/webapp/includes/phpass/c/crypt_private.c
/webapp/includes/js/bootstrap-toggle/js/bootstrap-toggle.js
/webapp/includes/js/chosen/index.html
/webapp/includes/js/chosen/docsupport/prism.css
/webapp/includes/phpmailer/class.phpmaileroauthgoogle.php
/webapp/includes/js/bootstrap-toggle/js/bootstrap-toggle.min.js
/webapp/includes/js/bootstrap-datepicker/css/datepicker.css
/webapp/includes/js/ckeditor/build-config.js
/webapp/includes/js/footable/footable.filter.min.js
/webapp/includes/plupload/js/i18n/cs.js
/webapp/includes/js/footable/css/footable.core.css
/webapp/includes/js/chosen/docsupport/style.css
/webapp/includes/js/chosen/chosen.proto.js
/webapp/includes/js/bootstrap-toggle/js/bootstrap-toggle.min.js.map
/webapp/includes/plupload/js/plupload.browserplus.js
/webapp/includes/js/jen/LICENSE
/webapp/includes/js/bootstrap-toggle/js/bootstrap2-toggle.js
/webapp/includes/timezone_identifiers_list.php
/webapp/includes/js/ckeditor/config.js
/webapp/includes/js/ckeditor/ckeditor.js
/webapp/includes/js/bootstrap-datepicker/js/bootstrap-datepicker.js
/webapp/includes/js/jquery.1.12.4.min.js
/webapp/includes/phpmailer/class.pop3.php
/webapp/includes/js/footable/css/footable.core.min.css
/webapp/includes/js/jquery-tags-input/jquery.tagsinput.css
/webapp/includes/js/footable/css/fonts/footable.eot
/webapp/includes/plupload/js/i18n/da.js
/webapp/includes/js/ckeditor/adapters/jquery.js
/webapp/includes/js/jquery-tags-input/jquery.tagsinput.min.js
/webapp/includes/js/ckeditor/contents.css
/webapp/includes/js/bootstrap-toggle/js/bootstrap2-toggle.min.js
/webapp/includes/js/jen/README.md
/webapp/includes/js/footable/css/footable.metro.css
/webapp/includes/js/footable/footable.min.js
/webapp/includes/phpmailer/class.smtp.php
/webapp/includes/plupload/js/jquery.plupload.queue/jquery.plupload.queue.js
/webapp/includes/timezones.php
/webapp/includes/js/bootstrap-toggle/js/bootstrap2-toggle.min.js.map
/webapp/includes/plupload/js/i18n/de.js
/webapp/includes/plupload/js/plupload.flash.js
/webapp/includes/plupload/js/jquery.plupload.queue/css/jquery.plupload.queue.css
/webapp/includes/plupload/js/i18n/el.js
/webapp/includes/plupload/js/plupload.flash.swf
/webapp/includes/phpmailer/composer.json
/webapp/includes/js/jquery.psendmodal.js
/webapp/includes/js/footable/css/fonts/footable.svg
/webapp/includes/js/footable/footable.paginate.min.js
/webapp/includes/plupload/js/i18n/es.js
/webapp/includes/js/footable/css/footable.metro.min.css
/webapp/includes/plupload/js/plupload.full.js
/webapp/includes/js/ckeditor/styles.js
/webapp/includes/js/jen/jen.js
/webapp/includes/plupload/js/i18n/et.js
/webapp/includes/plupload/js/plupload.gears.js
/webapp/includes/js/footable/footable.sort.min.js
/webapp/includes/js/jquery.validations.js
/webapp/includes/updates.functions.php
/webapp/includes/js/footable/css/fonts/footable.ttf
/webapp/includes/js/jen/bin/jen
/webapp/includes/plupload/js/plupload.html4.js
/webapp/includes/phpmailer/composer.lock
/webapp/includes/plupload/js/i18n/fa.js
/webapp/includes/js/jen/package.json
/webapp/includes/js/footable/css/footable.standalone.css
/webapp/includes/plupload/js/plupload.html5.js
/webapp/includes/updates.messages.php
/webapp/includes/plupload/js/plupload.js
/webapp/includes/js/js.cookie.js
/webapp/includes/plupload/js/i18n/fi.js
/webapp/includes/js/footable/css/footable.standalone.min.css
/webapp/includes/plupload/js/plupload.silverlight.js
/webapp/includes/js/footable/css/fonts/footable.woff
/webapp/includes/plupload/js/i18n/fr-ca.js
/webapp/includes/js/js.functions.php
/webapp/includes/plupload/js/plupload.silverlight.xap
/webapp/includes/js/main.js
/webapp/includes/phpmailer/extras/EasyPeasyICS.php
/webapp/includes/js/ckeditor/plugins/dialog/dialogDefinition.js
/webapp/includes/plupload/js/i18n/fr.js
/webapp/includes/phpmailer/extras/README.md
/webapp/includes/js/ckeditor/skins/moono-lisa/dialog.css
/webapp/includes/js/ckeditor/skins/moono-lisa/dialog_ie.css
/webapp/includes/plupload/js/i18n/hr.js
/webapp/includes/js/respond.min.js
/webapp/includes/phpmailer/extras/htmlfilter.php
/webapp/includes/plupload/js/i18n/hu.js
/webapp/includes/js/ckeditor/plugins/about/dialogs/about.js
/webapp/includes/js/ckeditor/skins/moono-lisa/dialog_ie8.css
/webapp/includes/widgets/news.php
/webapp/includes/plupload/js/i18n/it.js
/webapp/includes/phpmailer/extras/ntlm_sasl_client.php
/webapp/includes/js/ckeditor/plugins/clipboard/dialogs/paste.js
/webapp/includes/js/ckeditor/skins/moono-lisa/dialog_iequirks.css
/webapp/includes/js/ckeditor/plugins/link/dialogs/anchor.js
/webapp/includes/js/ckeditor/plugins/link/dialogs/link.js
/webapp/includes/plupload/js/i18n/ja.js
/webapp/includes/js/ckeditor/skins/moono-lisa/editor.css
/webapp/includes/plupload/js/i18n/ko.js
/webapp/includes/js/ckeditor/skins/moono-lisa/editor_gecko.css
/webapp/includes/plupload/js/i18n/lv.js
/webapp/includes/js/ckeditor/skins/moono-lisa/editor_ie.css
/webapp/includes/plupload/js/i18n/nl.js
/webapp/includes/js/ckeditor/skins/moono-lisa/editor_ie8.css
/webapp/includes/plupload/js/i18n/pl.js
/webapp/includes/js/ckeditor/skins/moono-lisa/editor_iequirks.css
/webapp/includes/js/ckeditor/skins/moono-lisa/readme.md
/webapp/includes/plupload/js/i18n/pt-br.js
/webapp/includes/plupload/js/i18n/ro.js
/webapp/includes/plupload/js/i18n/ru.js
/webapp/includes/plupload/js/i18n/sk.js
/webapp/includes/plupload/js/i18n/sr.js
/webapp/includes/plupload/js/i18n/sv.js
/webapp/lang/cftp_admin.pot
/webapp/lang/en.mo
/webapp/lang/en.po
/webapp/includes/js/bootstrap-toggle/css/bootstrap-toggle.css
/webapp/includes/js/bootstrap-toggle/css/bootstrap-toggle.min.css
/webapp/includes/js/bootstrap-toggle/css/bootstrap2-toggle.css
/webapp/includes/js/bootstrap-toggle/css/bootstrap2-toggle.min.css

Files found with a 500 responce:

/webapp/templates/common.php
/webapp/templates/default/template.php
/webapp/templates/gallery/template.php
/webapp/templates/pinboxes/template.php
/webapp/includes/active.session.php
/webapp/includes/core.update.php
/webapp/includes/core.update.silent.php
/webapp/includes/classes/actions-log.php
/webapp/includes/includes.php
/webapp/includes/Google/Oauth2/cache/Google_ApcCache.php
/webapp/includes/Google/Oauth2/auth/Google_Auth.php
/webapp/includes/language.php
/webapp/includes/classes/form-validation.php
/webapp/includes/Google/Oauth2/auth/Google_AuthNone.php
/webapp/includes/Google/Oauth2/cache/Google_FileCache.php
/webapp/includes/Google/Oauth2/io/Google_CurlIO.php
/webapp/includes/Google/Oauth2/cache/Google_MemcacheCache.php
/webapp/includes/Google/Oauth2/auth/Google_OAuth2.php
/webapp/includes/Google/Oauth2/auth/Google_P12Signer.php
/webapp/includes/Google/Oauth2/io/Google_HttpStreamIO.php
/webapp/includes/Google/Oauth2/io/Google_IO.php
/webapp/includes/classes/send-email.php
/webapp/includes/site.options.php
/webapp/includes/Google/Oauth2/auth/Google_PemVerifier.php
/webapp/includes/sys.vars.php
/webapp/includes/phpmailer/class.phpmaileroauth.php
/webapp/includes/thumb.php
/webapp/includes/userlevel_check.php
/webapp/includes/vars.php
/webapp/includes/phpmailer/get_oauth_token.php
/webapp/includes/widgets/actions-log.php
/webapp/includes/widgets/statistics.php
/webapp/includes/widgets/system-information.php


--------------------------------

```
{% endtab %}
{% endtabs %}

{% hint style="info" %}
**Dirbuster found http://172.16.64.81:80/webapp/img/custom/thumbs/users.bak**

```text
john1:password123
peter:youdonotguessthatone5
```

\*\*\*\*![users.bak contains usernames and passwords](../../../.gitbook/assets/image%20%2815%29.png)
{% endhint %}

### 172.16.64.91 \(Linux 3.13 - 95%\)

| Port | State | Service | Version |
| :--- | :--- | :--- | :--- |
| 80/tcp | open | http | Apache httpd 2.4.18 |
| 6379/tcp | open | redis | Redis key-value store |

{% tabs %}
{% tab title="Dirbuster" %}
* Target URL: [http://172.16.64.](http://172.16.64.81)91
* File Extension: \*
* File with list of dirs/files: /usr/share/dirbuster/wordlists/directory-list-lowercase-2.3-medium.txt
{% endtab %}

{% tab title="Report" %}
```bash

```
{% endtab %}
{% endtabs %}

### 172.16.64.92 \(Linux 3.12 - 95%\)

| Port | State | Service | Version |
| :--- | :--- | :--- | :--- |
| 22/tcp | open | ssh | OpenSSH 7.2p2 Ubuntu 4ubuntu2.8 |
| 53/tcp | open | domain | dnsmasq 2.75 |
| 80/tcp | open | http | Apache httpd 2.4.18 |
| 63306/tcp | open | mysql | MySQL 5.7.25-0ubuntu0.16.04.2 |

### 172.16.64.166 \(Linux 3.12 - 95%\)

| Port | State | Service | Version |
| :--- | :--- | :--- | :--- |
| 2222/tcp | open | ssh | OpenSSH 7.2p2 Ubuntu 4ubuntu2.8 |
| 8080/tcp | open | http | Apache httpd 2.4.18 |

{% hint style="info" %}
**Warning about password policy**

Employees are requested to change their default `CHANGEME` password.

```text
ssh admin@172.16.64.166 -p 2222                                                                                                             130 ⨯
#################################################################
#       WARNING! This system is for authorized users only.      #
#       You activity is being actively monitored.               #
#       Any suspicious behavior will be resported.              #
#################################################################

~~~~ WORK IN PROGRESS ~~~~
Dear employee! Remember to change the default CHANGEME password ASAP.

admin@172.16.64.166's password: 
```
{% endhint %}

