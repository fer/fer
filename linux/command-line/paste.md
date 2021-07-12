---
description: >-
  El comando paste sirve para combinar lineas de un fichero o varios ficheros.
  También puede ser útil para generar CSV mediante el uso de delimitadores.
---

# paste

## Ejemplos

Creamos 2 ficheros para combinarlos con `paste` que puedes generar así:

`ls -1 $HOME > /tmp/filenames.txtdu -hs $HOME/* | cut -f -1 > /tmp/fileusage.txt`

`filenames.txt` contiene nombres de ficheros y carpetas de `$HOME` :

\`\`\`% cat /tmp/filenames.txtApplicationsDesktopDocumentsDownloadsDropboxLibraryMoviesMusicPicturesPublicVirtualBox VMsnode\_modulesnpm

```text
```fileusage.txt``` contiene los tamaños ficheros y carpetas de ```$HOME```:

```% cat /tmp fileusage.txt816K455M 15G8.0K920M9.5G 0B112M432K 0B 14G 42M173M
```

Podemos utilizar `paste` para combinar estos dos ficheros línea a línea:

`% paste /tmp/fileusage.txt /tmp/filenames.txt816K Applications455M Desktop 15G Documents8.0K Downloads920M Dropbox9.5G Library 0B Movies112M Music432K Pictures 0B Public 14G VirtualBox VMs 42M node_modules173M npm`

También podemos generar una salida con formato [CSV](http://en.wikipedia.org/wiki/Comma-separated_values) usando el delimitador `,`:

\`\`\`paste -d, /tmp/fileusage.txt /tmp/filenames.txt

\`\`\`

#### Links

* [10 examples of paste command usage in Linux](http://www.theunixschool.com/2012/07/10-examples-of-paste-command-usage-in.html)

