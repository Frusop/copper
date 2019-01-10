#!/bin/sh

TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
SRCDIR=${SRCDIR:-$TOPDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

COPPERD=${COPPERD:-$SRCDIR/copperd}
COPPERCLI=${COPPERCLI:-$SRCDIR/copper-cli}
COPPERTX=${COPPERTX:-$SRCDIR/copper-tx}
COPPERQT=${COPPERQT:-$SRCDIR/qt/copper-qt}

[ ! -x $COPPERD ] && echo "$COPPERD not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
CUVER=($($COPPERCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for copperd if --version-string is not set,
# but has different outcomes for copper-qt and copper-cli.
echo "[COPYRIGHT]" > footer.h2m
$COPPERD --version | sed -n '1!p' >> footer.h2m

for cmd in $COPPERD $COPPERCLI $COPPERTX $COPPERQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${CUVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${CUVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
