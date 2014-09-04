sshrc
=====
cd debfolder-0.1
edit debian/changelog and change unstable to trusty
edit debian/control and change section to misc
edit debian/control and change url to http://stewart.guru

debuild:
	debuild -S -sa 

