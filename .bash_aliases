#---------------------Mina egna hittepå-grejer ---------------------
# Nicer ls: -f for file type indication (/ for dir, @ for link).
# -h for sizes in kB, MB etc instead of frickin bytes.
# -v for natural order (10 after 1).
alias l='ls -F -h --color=always -v'
# cs = cd + ls
function cs() { cd "$@" && l; }
# Because I keep typing the wrong command
alias cl='cs'

