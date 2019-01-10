
Debian
====================
This directory contains files used to package copperd/copper-qt
for Debian-based Linux systems. If you compile copperd/copper-qt yourself, there are some useful files here.

## copper: URI support ##


copper-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install copper-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your copper-qt binary to `/usr/bin`
and the `../../share/pixmaps/copper128.png` to `/usr/share/pixmaps`

copper-qt.protocol (KDE)

