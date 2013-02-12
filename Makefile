#########################################################################
# Creating the various distribution files.
#
# TARGET	PRODUCES		CONTAINS
# unixall	vim-#.#.tar.bz2		All runtime files and sources, for Unix
#
# html		vim##html.zip		HTML docs
#
#    All output files are created in the "dist" directory.  Existing files are
#    overwritten!
#    To do all this you need the Unix archive and compiled binaries.
#    Before creating an archive first delete all backup files, *.orig, etc.

MAJOR = 7
MINOR = 3

# CHECKLIST for creating a new version:
#
# - Update Vim version number.  For a test version in: src/version.h, Contents,
#   MAJOR/MINOR above, VIMMAJOR and VIMMINOR in src/Makefile, README*.txt,
#   runtime/doc/*.txt and nsis/gvim.nsi. Other things in README_os2.txt.  For a
#   minor/major version: src/GvimExt/GvimExt.reg, src/vim.def, src/vim16.def,
#   src/gvim.exe.mnf.
# - Adjust the date and other info in src/version.h.
# - Correct included_patches[] in src/version.c.
# - Compile Vim with GTK, Perl, Python, Python3, TCL, Ruby, MZscheme, Lua (if
#   you can make it all work), Cscope and "huge" features.  Exclude workshop
#   and SNiFF.
# - With these features: "make proto" (requires cproto and Motif installed;
#   ignore warnings for missing include files, fix problems for syntax errors).
# - With these features: "make depend" (works best with gcc).
# - If you have a lint program: "make lint" and check the output (ignore GTK
#   warnings).
# - Enable the efence library in "src/Makefile" and run "make test".  Disable
#   Python and Ruby to avoid trouble with threads (efence is not threadsafe).
# - Check for missing entries in runtime/makemenu.vim (with checkmenu script).
# - Check for missing options in runtime/optwin.vim et al. (with check.vim).
# - Do "make menu" to update the runtime/synmenu.vim file.
# - Add remarks for changes to runtime/doc/version7.txt.
# - Check that runtime/doc/help.txt doesn't contain entries in "LOCAL
#   ADDITIONS".
# - In runtime/doc run "make" and "make html" to check for errors.
# - Check if src/Makefile and src/feature.h don't contain any personal
#   preferences or the GTK, Perl, etc. mentioned above.
# - Check file protections to be "644" for text and "755" for executables (run
#   the "check" script).
# - Delete all *~, *.sw?, *.orig, *.rej files
# - "make unixall", "make html"
# - Make diff files against the previous release: "makediff7 7.1 7.2"

VIMVER	= vim-$(MAJOR).$(MINOR)
VERSION = $(MAJOR)$(MINOR)
VDOT	= $(MAJOR).$(MINOR)
VIMRTDIR = vim$(VERSION)

# Vim used for conversion from "unix" to "dos"
VIM	= vim

# How to include Filelist depends on the version of "make" you have.
# If the current choice doesn't work, try the other one.

include Filelist
#.include "Filelist"

default:
	@echo "This makefile only created various distribution files."
	@echo "You can compile Vim in src directory."

# All output is put in the "dist" directory.
dist:
	mkdir dist

# For the zip files we need to create a file with the comment line
dist/comment:
	mkdir dist/comment

COMMENT_HTML = comment/$(VERSION)-html

dist/$(COMMENT_HTML): dist/comment
	echo "Vim - Vi IMproved - v$(VDOT) documentation in HTML" > dist/$(COMMENT_HTML)

unixall: dist
	-rm -f dist/$(VIMVER).tar.bz2
	-rm -rf dist/$(VIMRTDIR)
	mkdir dist/$(VIMRTDIR)
	tar cf - \
		$(RT_ALL) \
		$(RT_ALL_BIN) \
		$(RT_UNIX) \
		$(RT_UNIX_DOS_BIN) \
		$(RT_SCRIPTS) \
		$(LANG_GEN) \
		$(LANG_GEN_BIN) \
		$(SRC_ALL) \
		$(SRC_UNIX) \
		$(SRC_DOS_UNIX) \
		$(EXTRA) \
		$(LANG_SRC) \
		| (cd dist/$(VIMRTDIR); tar xf -)
# Need to use a "distclean" config.mk file
	cp -f src/config.mk.dist dist/$(VIMRTDIR)/src/auto/config.mk
# Create an empty config.h file, make dependencies require it
	touch dist/$(VIMRTDIR)/src/auto/config.h
# Make sure configure is newer than config.mk to force it to be generated
	touch dist/$(VIMRTDIR)/src/configure
# Make sure ja.sjis.po is newer than ja.po to avoid it being regenerated.
# Same for cs.cp1250.po, pl.cp1250.po and sk.cp1250.po.
	touch dist/$(VIMRTDIR)/src/po/ja.sjis.po
	touch dist/$(VIMRTDIR)/src/po/cs.cp1250.po
	touch dist/$(VIMRTDIR)/src/po/pl.cp1250.po
	touch dist/$(VIMRTDIR)/src/po/sk.cp1250.po
	touch dist/$(VIMRTDIR)/src/po/zh_CN.cp936.po
	touch dist/$(VIMRTDIR)/src/po/ru.cp1251.po
	touch dist/$(VIMRTDIR)/src/po/uk.cp1251.po
# Create the archive.
	cd dist && tar cf $(VIMVER).tar $(VIMRTDIR)
	bzip2 dist/$(VIMVER).tar

no_title.vim: Makefile
	echo "set notitle noicon nocp nomodeline viminfo=" >no_title.vim

html: dist dist/$(COMMENT_HTML)
	-rm -rf dist/vim$(VERSION)html.zip
	cd runtime/doc && zip -9 -z ../../dist/vim$(VERSION)html.zip *.html <../../dist/$(COMMENT_HTML)
