#!/bin/bash
#*\
##=========+====================+================================================+
##RD         set-anyllm         | ALT Tools
##RFILE    +====================+=======+===============+======+=================+
##FD   set-anyllm.sh            |   1231| 10/16/24 09:24|      | v1.01`41016.0924
##FD   set-anyllm.sh            |   3777| 10/21/24 10:06|      | v1.03`41021.1006
##FD   set-anyllm.sh            |   5356| 10/22/24 08:10|      | v1.04`41022.0810
##FD   set-anyllm.sh            |   6240| 10/22/24 09:15|      | v1.04`41022.0915
##FD   set-anyllm.sh            |   6391| 10/23/24 07:25|      | v1.05`41023.0725
##FD   set-anyllm.sh            |   6401| 11/09/24 15:40|      | v1.05`41109.1540
##FD   set-anyllm.sh            |   6647| 11/11/24 22:00|   158| v1.05`41111.2200
##FD                            |
##DESC     .--------------------+-------+---------------+------+-----------------+
#            This script saves anyllm command to ._0/bin.
#
##LIC      .--------------------+----------------------------------------------+
#            Copyright (c) 2024 JScriptWare and 8020Date-FormR * Released under
#            MIT License: http://www.opensource.org/licenses/mit-license.php
##FNCS     .--------------------+----------------------------------------------+
#            help               |
#            setOSvars          |
#            showEm             |
#            mkScript           |
#            cpyToBin           |
#            Sudo               |
#                               |
##CHGS     .--------------------+----------------------------------------------+
# .(41016.01 10/16/24 RAM  9:24a|
# .(41021.01 10/21/24 RAM 10:06a|
# .(41022.01 10/22/24 RAM  8:10a|
# .(41022.01 10/22/24 RAM  9:15a|
# .(41023.01 10/23/24 RAM  7:25a|
# .(41109.06 11/09/24 RAM  3:40p| Add this heading and remove some stuff
# .(41111.03 11/11/24 RAM 10:22a| Add Show command and fix some stuff
# .(41111.10 11/11/24 RAM 10:00p| Fx OS == "Windows", not "windows"
#
##PRGM     +====================+===============================================+
##ID 69.600. Main0              |
##SRCE     +====================+===============================================+
#*/
#========================================================================================================== #  ===============================  #

  aVer="v0.05.41023.1443"  # set-anyllm.sh
  aVer="v0.05.41024.1000"  # set-anyllm.sh
  aVer="v0.05.41109.2000"  # set-anyllm.sh
  aVer="v0.05.41111.1022"  # set-anyllm.sh

  echo ""

# ---------------------------------------------------------------------------

function help() {
  echo "  Run . ./set-anyllm.sh commands  (${aVer} OS: ${aOS})"
  echo "    help  This help"
  echo "    doit  Create command anyllm"                                                # .(41111.03.1)
# echo "    doit  Make folders"                                                         ##.(41111.03.2)
  echo "    show  Show commands and ${aBashrc} and \$PATH"                              # .(41111.03.3)
# echo "    wipe  Wipe all the setup"                                                   ##.(41111.03.4)
  }
# -----------------------------------------------------------

function exit_wCR() {
  if [[ "${aOS}" != "windows" ]]; then echo ""; fi
     }
# -----------------------------------------------------------

function setOSvars() {
     aTS=$( date '+%y%m%d.%H%M' ); aTS=${aTS:2}
     aBashrc="$HOME/.bashrc"
     aBinDir="/Home/._0/bin"
     aOS="linux"
  if [[ "${OS:0:7}" == "Windows" ]]; then
     aOS="windows";
     aBinDir="/C/Home/._0/bin"
     fi
  if [[ "${OSTYPE:0:6}" == "darwin" ]]; then
     aBashrc="$HOME/.zshrc"
     aBinDir="/Users/Shared/._0/bin"
     aOS="darwin"
     fi
     }
# -----------------------------------------------------------

function Sudo() {                                                                                           # .(41105.03.1 RAM Write Sudo)
  if [[ "${OS:0:7}" != "Windows" ]]; then if [ "${USERNAME}" != "root" ]; then sudo "$@"; fi; fi            # .(41111.10.1 RAM Was: "windows").(41105.03.2)
     }                                                                                                      # .(41105.03.3)
# -----------------------------------------------------------

                                  aCmd="help"
#  if [[ "$1" == ""      ]]; then aCmd="help";   fi
   if [[ "$1" == "help"  ]]; then aCmd="help";   fi
   if [[ "$1" == "doit"  ]]; then aCmd="doIt";   fi
   if [[ "$1" == "show"  ]]; then aCmd="showEm"; fi

# ---------------------------------------------------------------------------

function showEm() {

  echo "  aBinDir: '${aBinDir}'"
  if [ -d "${aBinDir}" ]; then ls -l "${aBinDir}" | awk 'NR > 1 { print "    " $0 }'; fi
  echo ""

  echo "  .Bashrc: '${aBashrc}'"
  if [ -f "${aBashrc}" ]; then cat  "${aBashrc}" | awk '{ print "    " $0 }'; fi
  echo -e "    -------\n"

  echo "  PATH:"
  echo "${PATH}" | awk '{ gsub( /:/, "\n" ); print}' | awk '/bin$/ { print "    " $0 }' # .(41111.03.4)
  }
# -----------------------------------------------------------

function  mkScript() {
# echo "    aAnyLLMscr:  $2/$3"
  echo "#!/bin/bash"   >"$2/$3"
  echo "  $1 \"\$@\"" >>"$2/$3"
  chmod 777 "$2/$3"
  }
# -----------------------------------------------------------

function cpyToBin() {
# return

  aJPTs_JDir="${aBinDir}"   # "/Users/Shared/._0/bin"
# aJPTs_GitR="${aRepo_Dir}/._2/JPTs/gitr.sh"                                            # .(41109.14.2 RAM Not needed )
  aAnyLLMscr="${aRepo_Dir}/run-anyllm.sh"

# echo ""
# echo " aJPTs_JDir: ${aJPTs_JDir}";
# echo " aJPTs_GitR: ${aJPTs_GitR}";
# echo " alias gitr: ${aJPTs_JDir}/gitr.sh";
# echo " copying run-anyllm.sh and gitr to: \"${aJPTs_JDir}\""; echo ""

  if [ ! -d  "${aJPTs_JDir}" ]; then sudo mkdir -p  "${aJPTs_JDir}";                    echo "  Done: created ${aJPTs_JDir}";
                                     Sudo chmod 777 "${aJPTs_JDir}"; fi                 # .(41111.03.5 RAM was sudo)

  if [   -f  "${aAnyLLMscr}" ]; then mkScript "${aAnyLLMscr}" "${aJPTs_JDir}" "anyllm"; echo "  Done: created ${aJPTs_JDir}/anyllm";
                                     Sudo chmod 777 "${aAnyLLMscr}"; fi
  }
# ---------------------------------------------------------------------------

  aRepo_Dir="$(pwd)"
  cd ..
  aProj_Dir="$(pwd)"

  setOSvars; # echo "  OS: ${aOS}"

  if [[ "${aCmd}" == "help"   ]]; then help; fi
  if [[ "${aCmd}" == "showEm" ]]; then showEm; fi
# if [[ "${aCmd}" == "doIt"   ]]; then setBashrc; fi                                    ##.(41111.03.6)
  if [[ "${aCmd}" == "doIt"   ]]; then cpyToBin; fi

# ---------------------------------------------------------------------------

  cd "${aRepo_Dir}"  ||

  exit_wCR


