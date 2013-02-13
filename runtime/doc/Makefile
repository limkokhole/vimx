#
# Makefile for the Vim documentation on Unix
#
# If you get "don't know how to make scratch", first run make in the source
# directory.  Or remove the include below.

AWK = awk

# Set to $(VIMTARGET) when executed from src/Makefile.
VIMEXE = vim

# include the config.mk from the source directory.  It's only needed to set
# AWK, used for "make html".  Comment this out if the include gives problems.
include ../../src/auto/config.mk

DOCS = \
	autocmd.txt \
	change.txt \
	cmdline.txt \
	debug.txt \
	debugger.txt \
	develop.txt \
	diff.txt \
	digraph.txt \
	editing.txt \
	eval.txt \
	filetype.txt \
	fold.txt \
	ft_ada.txt \
	ft_sql.txt \
	gui.txt \
	gui_x11.txt \
	help.txt \
	helphelp.txt \
	howto.txt \
	if_cscop.txt \
	if_lua.txt \
	if_mzsch.txt \
	if_perl.txt \
	if_pyth.txt \
	if_ruby.txt \
	if_sniff.txt \
	if_tcl.txt \
	indent.txt \
	index.txt \
	insert.txt \
	intro.txt \
	map.txt \
	mbyte.txt \
	message.txt \
	mlang.txt \
	motion.txt \
	netbeans.txt \
	options.txt \
	os_unix.txt \
	pattern.txt \
	pi_getscript.txt \
	pi_gzip.txt \
	pi_netrw.txt \
	pi_paren.txt \
	pi_spec.txt \
	pi_tar.txt \
	pi_vimball.txt \
	pi_zip.txt \
	print.txt \
	quickfix.txt \
	quickref.txt \
	quotes.txt \
	recover.txt \
	remote.txt \
	repeat.txt \
	rileft.txt \
	scroll.txt \
	sign.txt \
	spell.txt \
	sponsor.txt \
	starting.txt \
	syntax.txt \
	tabpage.txt \
	tagsrch.txt \
	term.txt \
	tips.txt \
	todo.txt \
	uganda.txt \
	undo.txt \
	usr_01.txt \
	usr_02.txt \
	usr_03.txt \
	usr_04.txt \
	usr_05.txt \
	usr_06.txt \
	usr_07.txt \
	usr_08.txt \
	usr_09.txt \
	usr_10.txt \
	usr_11.txt \
	usr_12.txt \
	usr_20.txt \
	usr_21.txt \
	usr_22.txt \
	usr_23.txt \
	usr_24.txt \
	usr_25.txt \
	usr_26.txt \
	usr_27.txt \
	usr_28.txt \
	usr_29.txt \
	usr_30.txt \
	usr_31.txt \
	usr_32.txt \
	usr_40.txt \
	usr_41.txt \
	usr_42.txt \
	usr_43.txt \
	usr_44.txt \
	usr_45.txt \
	usr_90.txt \
	usr_toc.txt \
	various.txt \
	version4.txt \
	version5.txt \
	version6.txt \
	version7.txt \
	vi_diff.txt \
	visual.txt \
	workshop.txt

HTMLS = \
	autocmd.html \
	change.html \
	cmdline.html \
	debug.html \
	debugger.html \
	develop.html \
	diff.html \
	digraph.html \
	editing.html \
	eval.html \
	filetype.html \
	fold.html \
	ft_ada.html \
	ft_sql.html \
	gui.html \
	gui_x11.html \
	helphelp.html \
	howto.html \
	if_cscop.html \
	if_lua.html \
	if_mzsch.html \
	if_ole.html \
	if_perl.html \
	if_pyth.html \
	if_ruby.html \
	if_sniff.html \
	if_tcl.html \
	indent.html \
	index.html \
	insert.html \
	intro.html \
	map.html \
	mbyte.html \
	message.html \
	mlang.html \
	motion.html \
	netbeans.html \
	options.html \
	os_unix.html \
	os_vms.html \
	pattern.html \
	pi_getscript.html \
	pi_gzip.html \
	pi_netrw.html \
	pi_paren.html \
	pi_spec.html \
	pi_tar.html \
	pi_vimball.html \
	pi_zip.html \
	print.html \
	quickfix.html \
	quickref.html \
	quotes.html \
	recover.html \
	remote.html \
	repeat.html \
	rileft.html \
	scroll.html \
	sign.html \
	spell.html \
	sponsor.html \
	starting.html \
	syntax.html \
	tabpage.html \
	tags.html \
	tagsrch.html \
	term.html \
	tips.html \
	todo.html \
	uganda.html \
	undo.html \
	usr_01.html \
	usr_02.html \
	usr_03.html \
	usr_04.html \
	usr_05.html \
	usr_06.html \
	usr_07.html \
	usr_08.html \
	usr_09.html \
	usr_10.html \
	usr_11.html \
	usr_12.html \
	usr_20.html \
	usr_21.html \
	usr_22.html \
	usr_23.html \
	usr_24.html \
	usr_25.html \
	usr_26.html \
	usr_27.html \
	usr_28.html \
	usr_29.html \
	usr_30.html \
	usr_31.html \
	usr_32.html \
	usr_40.html \
	usr_41.html \
	usr_42.html \
	usr_43.html \
	usr_44.html \
	usr_45.html \
	usr_90.html \
	usr_toc.html \
	various.html \
	version4.html \
	version5.html \
	version6.html \
	version7.html \
	vi_diff.html \
	vimindex.html \
	visual.html \
	workshop.html

.SUFFIXES:
.SUFFIXES: .c .o .txt .html

all: tags vim.man evim.man vimdiff.man xxd.man

# Use Vim to generate the tags file.  Can only be used when Vim has been
# compiled and installed.  Supports multiple languages.
vimtags: $(DOCS)
	$(VIMEXE) -u NONE -esX -c "helptags ++t ." -c quit

# Use "doctags" to generate the tags file.  Only works for English!
tags: doctags $(DOCS)
	./doctags $(DOCS) | LANG=C LC_ALL=C sort >tags
	uniq -d -2 tags

doctags: doctags.c
	$(CC) doctags.c -o doctags

vim.man: vim.1
	nroff -man vim.1 | sed -e s/.//g > vim.man

evim.man: evim.1
	nroff -man evim.1 | sed -e s/.//g > evim.man

vimdiff.man: vimdiff.1
	nroff -man vimdiff.1 | sed -e s/.//g > vimdiff.man

xxd.man: xxd.1
	nroff -man xxd.1 | sed -e s/.//g > xxd.man

# Awk version of .txt to .html conversion.
html: noerrors tags $(HTMLS)
	@if test -f errors.log; then more errors.log; fi

noerrors:
	-rm -f errors.log

$(HTMLS): tags.ref

.txt.html:
	$(AWK) -f makehtml.awk $< >$@

# index.html is the starting point for HTML, but for the help files it is
# help.txt.  Therefore use vimindex.html for index.txt.
index.html: help.txt
	$(AWK) -f makehtml.awk help.txt >index.html

vimindex.html: index.txt
	$(AWK) -f makehtml.awk index.txt >vimindex.html

tags.ref tags.html: tags
	$(AWK) -f maketags.awk tags >tags.html

# Perl version of .txt to .html conversion.
# There can't be two rules to produce a .html from a .txt file.
# Just run over all .txt files each time one changes.  It's fast anyway.
perlhtml: tags $(DOCS)
	./vim2html.pl tags $(DOCS)

clean:
	-rm doctags *.html tags.ref
