#!/bin/bash
#*\
##=========+====================+================================================+
##RD         run-anyllm         | ALT Tools
##RFILE    +====================+=======+===============+======+=================+
##FD   run-anyllm.sh            |   2658| 10/16/24 09:23|      | v1.01`41016.0923
##FD   run-anyllm.sh            |   3540| 10/16/24 10:10|      | v1.02`41016.1010
##FD   run-anyllm.sh            |   3917| 10/21/24 08:12|      | v1.03`41021.0812
##FD   run-anyllm.sh            |   5178| 10/22/24 16:55|      | v1.05`41022.1655
##FD   run-anyllm.sh            |   5486| 10/23/24 08:37|      | v1.05`41023.0837
##FD   run-anyllm.sh            |   5486| 11/09/24 16:10|      | v1.05`41109.1610
##FD   run-anyllm.sh            |   5486| 11/11/24 19:08|      | v1.05`41111.1908
##FD   set-anyllm.sh            |  17748| 11/12/24 08:36|   322| v1.05`41112.0830
##FD   set-anyllm.sh            |  19279| 11/14/24 10:30|   354| v1.05`41114.1030
##FD   set-anyllm.sh            |  23622| 11/17/24 17:51|   420| v1.05`41117.1745
##FD   set-anyllm.sh            |  21667| 12/01/24 21:25|   395| v1.05`41201.2125
##FD   set-anyllm.sh            |  23120| 12/03/24 09:00|   413| v1.05`41203.0900
##FD   set-anyllm.sh            |  27963| 12/04/24 09:55|   458| v1.05`41204.0955
##FD   set-anyllm.sh            |  28803| 12/05/24 09:50|   467| v1.05`41205.0950
##FD   set-anyllm.sh            |  29230| 12/24/24 11:00|   470| v1.05`41224.1100
##FD   set-anyllm.sh            |  29230| 12/25/24 16:40|   470| v1.05`41225.1640
#
#DESC     .---------------------+-------+---------------+------+-----------------+
#            This script runs AnyLLM Apps
#
##LIC      .--------------------+----------------------------------------------+
#            Copyright (c) 2024 JScriptWare and 8020Date-FormR * Released under
#            MIT License: http://www.opensource.org/licenses/mit-license.php
##FNCS     .--------------------+----------------------------------------------+
#            help               |
#            setOSvars          |
#            getRepoDir         |
#            showPorts          |
#            killPort           |
#            copyEnvs           |
#            startApp           |
#            stopApp            |
#                               |
##CHGS     .--------------------+----------------------------------------------+
#.(41016.01  10/16/24 RAM  9:23a|
#.(41016.01  10/16/24 RAM 10:10a|
#.(41016.01  10/21/24 RAM  8:12a|
#.(41016.01  10/22/24 RAM  4:55p|
#.(41016.01  10/23/24 RAM  8:37a|
#.(41109.07  11/09/24 RAM  4:10p| Add this heading
#.(41109.08  11/09/24 RAM  4:30p| Get remote for origin only
#.(41109.09  11/09/24 RAM  6:10p| Write show ports for Windows
#.(41111.06  11/09/24 RAM  7:08p| Allow anyllm to run from anywhere
#.(41112.03  11/12/24 RAM  8:30a| Add version and source
#.(41114.02  11/14/24 RAM 10:30a| Write and use setIPAddr for frontend .env
#.(41115.02  11/14/24 RAM 10:30a| Update AnyLLM and ALTools
#.(41116.03  11/16/24 RAM 11:40a| Add -bdf, for bDebug, bDoit, bForce
#.(41114.02b 11/17/24 RAM  5:45p| Fix setIPAddr for Mac and Unix
#.(41201.02  12/01/24 RAM  3:00p| Use FRT's Show/Kill Port(s)
#.(41201.06  12/01/24 RAM  9:25p| Cleanup setup command
#.(41115.02b 12/03/24 RAM  9:00a| Update update command
#.(41115.02c 12/04/24 RAM  8:33a| Update update command msg if no branch
#.(41115.02d 12/04/24 RAM  2:30p| Fix update ALTools
#.(41109.08b 12/04/24 RAM  9:55p| Check for Repos/Robin
#.(41115.02f 12/05/24 RAM  9:50p| Don't delete branch for update altools
#.(41224.01  12/24/24 RAM 11:00a| Fix blank lines
#.(41114.02c 12/24/24 RAM  4:40p| Fix setIPAddr for Unix

##PRGM     +====================+===============================================+
##ID 69.600. Main0              |
##SRCE     +====================+===============================================+
#*/
#========================================================================================================== #  ===============================  #

  aVer="v0.05.41023.1335"  # run-anyllm.sh
  aVer="v0.05.41024.1000"  # run-anyllm.sh
  aVer="v0.05.41109.1410"  # run-anyllm.sh
  aVer="v0.05.41111.1908"  # run-anyllm.sh
  aVer="v0.05.41112.0830"  # run-anyllm.sh
  aVer="v0.05.41114.1030"  # run-anyllm.sh
  aVer="v0.05.41115.1230"  # run-anyllm.sh
  aVer="v0.05.41116.1140"  # run-anyllm.sh
  aVer="v0.05.41117.1745"  # run-anyllm.sh
  aVer="v0.05.41201.2125"  # run-anyllm.sh
  aVer="v0.05.41203.0900"  # run-anyllm.sh
  aVer="v0.05.41204.0830"  # run-anyllm.sh
  aVer="v0.05.41204.0955"  # run-anyllm.sh
  aVer="v0.05.41205.0950"  # run-anyllm.sh
  aVer="v0.05.41224.1100"  # run-anyllm.sh
  aVer="v0.05.41225.1640"  # run-anyllm.sh

  # ---------------------------------------------------------------------------

function help() {
     echo ""
     echo "  Run AnyLLM Commands (${aVer}  OS: ${aOS})"
     echo "    Setup              Run yarn setup for AnythingLLM"
     echo "    Copy envs          Copy .env.example files to .env files"
     echo "    Start [{App}|all]  Start AnyLLM App: collector, frontend, server or all apps"
     echo "    Stop  [{App}|all]  Stop  AnyLLM App: collector, frontend, server or all apps"
     echo "    Show ports         List Program, PID and Port"
     echo "    Kill port {Port}   Kill port number"
     echo "    Update [{Branch}]  Update branch: Master, JPTools, or both (default)"    # .(41203.03.1)
     echo "    Version            Show Version and Location"                            # .(41112.03.1)
     echo "    Update             Update Anything-LLM and ALTools"                      # .(41115.02b.10)
#    echo ""
     exit_wCR
     }
# ---------------------------------------------------------------------------

function end_wCR() {                                                                    # .(41204.03.1 RAM Write end_wCR. Who knows why?)
  if [ "${aOS}" != "windows" ]; then echo ""; return; fi                                # .(41224.01.4 RAM was != darwin).(41204.03.2)
     }                                                                                  # .(41204.03.3)
function exit_wCR() {
  if [ "${aOS}" != "windows" ]; then echo ""; fi                                        # .(41224.01.5 RAM was == darwin)
# if [ "$1" == "exit" ]; then exit; fi
     exit
     }
# ---------------------------------------------------------------------------

function setOSvars() {
     aTS=$( date '+%y%m%d.%H%M' ); aTS=${aTS:2}
     aBashrc="$HOME/.bashrc"
     aBinDir="/home/._0/bin"                                                            # .(41224.01.6 RAM Was Home)
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

function getBinVersion() {                                                                                  # .(41112.01.1 RAM Write getBinVersion Beg)
  aBinFile="$( cat "${aBinDir}/$1" | awk '/\.sh/ { sub( /"\$.+/, "" ); sub( /^ */, "" ); sub( / *$/, "" ); print }' )"
# aBinFile="$( cat "${aBinDir}/$1" | awk '/\.sh/' )"; echo "  '${aBinFile}'"; exit
  aBinVer="$(  cat "${aBinFile}"   | awk '/ aVer="v[0-9]/ { sub( /aVer=/, "" ); a = $1 }; END{ print a }' )"
  }                                                                                                         # .(41112.01.1 End)
# -----------------------------------------------------------

 function getRepoDir() {
#  aBranch="$( git branch | awk '/\*/ { print substr($0,2) }' )"
#  echo "AnyLLM[ 90] "
   aRepos="$( echo "$(pwd)"       |  awk '{ match($0, /.*[Rr][Ee][Pp][Oo][Ss]/); print substr($0,1,RLENGTH) }' )";
   if [ -d "${aRepos}/Robin"      ]; then aRepos="${aRepos}/Robin"; fi                                          # .(41109.08b.1 RAM Check for Repos/Robin)
#  aRepo="$( git remote -v        |  awk '/push/         { sub( /.+\//, ""); sub( /\.git.+/, "" ); print }' )"  # .(41109.08.1)
   aRepo="$( git remote -v        |  awk '/origin.+push/ { sub( /.+\//, ""); sub( /\.git.+/, "" ); print }' )"  # .(41109.08.1 RAM Just for origin ??)
#  echo "AnyLLM[ 94]  aRepo: ${aRepo}"
#  aProjDir="${aRepoDir%%_*}"
#  aProjDir="$( echo "$(pwd)"     | awk '{ sub( "'${aRepoDir}'", "" ); print }' )"
#  aAWK='{ sub( "'${aRepos//\//\/}'/", "" ); sub( /[\/_].*/, "_"); print }';                echo "  aAWK:    '${aAWK}'"  # double up /s
   aAWK='{ sub( "'${aRepos}'/", "" );  sub( /_\/*.+/, "" ); sub( /\/.+/, "" ); print }';  # echo "  aAWK:    '${aAWK}'"  # .(41109.08.2 RAM awk: cmd. line:1: warning: escape sequence `\/' treated as plain `/')
#  aAWK='{ sub( "'${aRepos}'/", "" );  sub( "_/*.+",  "" ); sub( "/.+",  "" ); print }';    echo "  aAWK:    '${aAWK}'"  ##.(41109.08.2
   aProject="$( echo "$(pwd)"     |  awk "${aAWK}" )" 2>/dev/null
#  echo "AnyLLM[101]  aProject: ${aProject}"

   aStgDir="$(  echo "$(pwd)"     |  awk '{ sub( "'.+${aProject}'", "" ); print }' )"
#  aStage="$(   echo "${aStgDir}" |  awk '{ sub( "^[_\/]+"        , "" ); print }' )"   ##.(41109.08.3 RAM awk: cmd. line:1: warning: escape sequence `\/' treated as plain `/')
   aStage="$(   echo "${aStgDir}" |  awk '{ sub( "^[_/]+"         , "" ); print }' )"   # .(41109.08.3)
#  echo "AnyLLM[105]  aStage:    '${aStage}'"; # exit

   aRepoDir="${aRepos}/${aProject}${aStgDir}"
   if [ "${aRepo}" == "" ]; then aRepo="${aProject}${aStgDir}"; fi

   if [ "${bDebug}" == "1" ]; then
   echo ""
   echo "  aRepos:   '${aRepos}'"
   echo "  aRepo:    '${aRepo}'"
   echo "  aProject: '${aProject}'"
   echo "  aStage:   '${aStage}'"
   echo "  aRepoDir: '${aRepoDir}'"
   exit_wCR
   fi
   }
# ---------------------------------------------------------------------------

function get_subnet_ip() {
   local pattern=$1
   for ip in "${mIPs[@]}"; do
       if [[ $ip =~ $pattern ]]; then
           echo "$ip"
           return 0
       fi
   done
   return 1
   }

function setIPAddr() {                                                                                                   # .(41114.02.1  RAM Write setIPAddr)
#  if [ "${aOS}" == "windows" ]; then             aIP="$(   ipconfig | awk '/IPv4 / { a = substr( $0, 40 ) }; END {                      print a }' )"; fi
#  if [ "${aOS}" == "darwin"  ]; then             aIP="$(   ifconfig | awk '/inet / { a = $2               }; END {                      print a }' )"; fi   
#  if [ "${aOS}" == "linux"   ]; then             aIP="$(   ip a     | awk '/inet / { a = $2               }; END { sub( /\/.*/, "", a); print a }' )"; fi   
                                                                                                                         
#  if [ "${aOS}" != "windows" ]; then             mIPs=( $( ifconfig | awk '/inet / { print substr( $0,  7 ) }' ) )      ##.(41114.02.2  RAM For Mac).(41114.02b.2)
   if [ "${aOS}" == "darwin"  ]; then             mIPs=( $( ifconfig | awk '/inet / { print substr( $0,  7 ) }' ) ); fi  # .(41114.02c.1).(41114.02b.2 RAM For Mac)
   if [ "${aOS}" == "windows" ]; then mapfile  -t mIPs < <( ipconfig | awk '/IPv4 / { print substr( $0, 40 ) }'   ); fi  # .(41114.02c.3).(41114.02.3 RAM For Windows)
   if [ "${aOS}" == "linux"   ]; then mapfile  -t mIPs < <( ip a     | awk '/inet / { print substr( $0,  7 ) }'   ); fi  # .(41114.02c.4 RAM Only works in vatest versions of Ubuntu)).(41114.02b.4 RAM for Unix)
#      else                                                                                                              ##.(41114.02b.3) 
#        fi; fi                                                                                                          ##.(41114.02.5).(41114.02c.5)

         aIPAddr="$( get_subnet_ip "^192\.168\." || \
                     get_subnet_ip "^10\.0\.0\." || \
                     get_subnet_ip "^172\."      || \
                              echo  "127.0.0.1" )"

       echo "  Setting ./frontend/.env IP Address to ${aIPAddr}"
   if [ "${aOS}" == "darwin" ]; then                                                    # .(41114.02.6)
       sed -i '' "s/^[[:space:]]*SERVER_IP=.*/  SERVER_IP=${aIPAddr}/" ./frontend/.env  # .(41114.02.7)
     else                                                                               # .(41114.02.8)
       sed -i    "/^[[:space:]]*SERVER_IP=/ c\  SERVER_IP=${aIPAddr}" ./frontend/.env
       fi                                                                               # .(41114.02.9)
       }                                                                                # .(41114.02.1 End)
# ---------------------------------------------------------------------------

 function killPort() {
     if [ $# -eq 0 ] || [ "$1" == "all" ]; then
         echo -e "\n  Usage: kill ports <port_number(s)>\n"
     else
         for nPort in "$@"; do
             jpt kill port "${nPort}"
         done

#        local port="$1"
#        local pid=$(lsof -t -i:"$port")
#        if [ -z "$pid" ]; then
#            echo -e "\n* No process found running on port $port"
#        else
#            echo -e "\n  Killing process $pid running on port $port"
#            kill "$pid"
#        fi
     fi
    }
# ---------------------------------------------------------------------------

  if [ ! -d ".git" ]; then
     aPath="$( dirname $0)"; aScriptDir="${aPath##*/}";        # echo "  aScriptDir:  ${aScriptDir}"        # .(41111.06.1 RAM Enable anyllm to run from anythere beg)
     aCurrentDir="$( pwd )"; aCurrentDir="${aCurrentDir##*/}"; # echo "  aCurrentDir: ${aCurrentDir}"
     if [ "${aScriptDir}" != "${aCurrentDir}" ]; then
#       echo -e "\n* You are not in a Git Repository"
        echo -e "\n* You are not in the ${aScriptDir} folder, but that's ok."
        cd "${aPath}";
#       exit_wCR
        fi                                                                                                  # .(41111.06.1 End)
     fi
# ---------------------------------------------------------------------------

while [[ $# -gt 0 ]]; do  # Loop through all arguments                                                      # .(41116.03.1 Add Arg loop Beg)
    case "$1" in
        -doit|--doit)    bDoit=1  ;;
        -debug|--debug)  bDebug=1 ;;
        -[bdf]*)          [[ "$1" =~ "b" ]] && bDebug=1; [[ "$1" =~ "d" ]] && bDoit=1; [[ "$1" =~ "f" ]] && bForce=1 ;;
        *)
         mArgs+=("$( echo "${1:0:3}" | sed 'y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/')"); # mARGs+=("$1")
#        echo -e "\n    Debug: Adding '$1' to mARGs"
         mARGs+=("$1")
#        echo "    Debug: mARGs now contains: ${mARGs[@]}"
#        i=${#mARGs[@]}; echo "    Debug: mARGs[ $((i-1)) ] now contains: ${mARGs[ $((i-1)) ]}"
         i=${#mARGs[@]}; i=$((i-1))  # current length, origin 0
#        echo "  - gitR2[236]  \${mARGs[${i}]}: '${mARGs[${i}]}', \$$i: '$1'"
         ;;
    esac
    shift
  done
    set -- "${mArgs[@]}"  # Restore the command arguments, lower case, three letters                        # .(41116.03.1 End)
#   echo ""                                                                             ##.(41224.01.7 RAM Remove echo "")
                                                    aArgFlags="-"                                           # .(41116.03.2 RAM Add aArgFlags Beg)
    if [ "${bDoit}"     == "1" ]; then aArgFlags="${aArgFlags}d"; fi
    if [ "${bDebug}"    == "1" ]; then aArgFlags="${aArgFlags}b"; fi
    if [ "${bForce}"    == "1" ]; then aArgFlags="${aArgFlags}f"; fi
    if [ "${aArgFlags}" == "-" ]; then aArgFlags=""; fi                                                     # .(41116.03.2 End)

# ---------------------------------------------------------------------------

    setOSvars
    getRepoDir

# ---------------------------------------------------------------------------

          aArg1=$1; aArg2=$2; aArg3=$3; aCmd="help"
  if [ "${aArg1:0:5}" == "set" ]; then  aCmd="setup";   fi
  if [ "${aArg1:0:3}" == "ver" ]; then  aCmd="version"; fi                               # .(411112.03.2)
  if [ "${aArg1:0:3}" == "sou" ]; then  aCmd="source";  fi                               # .(411112.03.5)

  if [ "${aArg1:0:3}" == "cop" ] && [ "${aArg2:0:3}" == "env" ]; then aCmd="copyEnvs";  fi

  if [ "${aArg1:0:3}" == "sta" ] && [ "${aArg2:0:3}" == "app" ]; then aCmd="startApp";  fi
  if [ "${aArg1:0:3}" == "sta" ] && [ "${aArg2:0:1}" == "c"   ]; then aCmd="startApp";  aArg3="c"; fi
  if [ "${aArg1:0:3}" == "sta" ] && [ "${aArg2:0:1}" == "f"   ]; then aCmd="startApp";  aArg3="f"; fi
  if [ "${aArg1:0:3}" == "sta" ] && [ "${aArg2:0:1}" == "s"   ]; then aCmd="startApp";  aArg3="s"; fi
  if [ "${aArg1:0:3}" == "sta" ] && [ "${aArg2:0:1}" == "a"   ]; then aCmd="startApp";  aArg3="a"; fi

  if [ "${aArg1:0:3}" == "sto" ] && [ "${aArg2:0:3}" == "app" ]; then aCmd="stopApp";   fi
  if [ "${aArg1:0:3}" == "sto" ] && [ "${aArg2:0:1}" == "c"   ]; then aCmd="stopApp";   aArg3="c"; fi
  if [ "${aArg1:0:3}" == "sto" ] && [ "${aArg2:0:1}" == "f"   ]; then aCmd="stopApp";   aArg3="f"; fi
  if [ "${aArg1:0:3}" == "sto" ] && [ "${aArg2:0:1}" == "s"   ]; then aCmd="stopApp";   aArg3="s"; fi
  if [ "${aArg1:0:3}" == "sto" ] && [ "${aArg2:0:1}" == "a"   ]; then aCmd="stopApp";   aArg3="a"; fi

  if [ "${aArg1:0:3}" == "kil" ];                                then aCmd="killPort";  fi
  if [ "${aArg1:0:3}" == "kil" ] && [ "${aArg2:0:3}" == "por" ]; then aCmd="killPort";  fi
  if [ "${aArg1:0:3}" == "sho" ] && [ "${aArg2:0:3}" == "por" ]; then aCmd="showPorts"; fi

  if [ "${aArg1:0:3}" == "upd" ];                                then aCmd="update"; fi # .(41115.02.2)

# echo "  aCmd: '${aCmd}', aArg1: '${aArg1}', aArg2: '${aArg2}', \$3: '$3', mARGs[2]: '${mARGs[2]}', bDoit: '${bDoit}', bDebug: '${bDebug}', bForce: '${bForce}', aArgFlags: '${aArgFlags}'"; exit;

# ---------------------------------------------------------------------------

  if [ "${aCmd}" == "help" ]; then help; fi

# ---------------------------------------------------------------------------

  if [ "${aCmd}" == "version" ] || [ "${aCmd}" == "source" ]; then
     getBinVersion "anyllm"                                                             # .(41112.03.2 RAM Use it)
     echo ""                                                                            # .(41112.03.3)
     echo "  anyllm Version:  ${aBinVer}"                                               # .(41112.03.4 RAM Display it)
     echo "  anyllm Script:    ${aBinDir}/anyllm"                                       # .(41112.03.5)
     echo "  anyllm Location: '${aBinFile}'"                                            # .(41112.03.6)
     exit_wCR
     fi
# ---------------------------------------------------------------------------

  if [ "${aCmd}" == "update" ]; then                                                    # .(41115.02.3 RAM Write anyllm update command Beg)

     aBranch="${mARGs[1]}"; if [ "${aBranch}" == "" ]; then aBranch="both"; fi          # .(41115.02b.11)
     aBranch="$( echo "${aBranch}" | awk '{ print tolower($0) }' )"                     # .(41115.02b.12)

   if [ "${aBranch}" == "frtools" ] || [ "{aBranch}" == "both" ]; then                  # .(41115.02b.13)
     if [ -d "${aRepos}/FRTools"               ]; then cd "${aRepos}/FRTools"; fi       # .(41115.02e.xx Beg)
     if [ -d "${aRepos}/FRTools_/prod2-master" ]; then cd "${aRepos}/FRTools_/prod2-master"; fi
     if [ -d "${aRepos}/FRTools_prod2-master"  ]; then cd "${aRepos}/FRTools_prod2-master";  fi
     if [ -d "${aRepos}/FRTools_/FRTools_prod2-master"  ]; then cd "${aRepos}/FRTools_/FRTools_prod2-master";  fi
                                                                                        # .(41115.02e.xx End)
     gitr update "${aArgFlags}"                                                         # .(41116.03.3)
     end_wCR                                                                            # .(41204.03..4)
     echo -e "  --------------------------------------------------------------------------------------------------"
     bOK=1; fi                                                                          # .(41115.02b.14)

   if [ "${aBranch}" == "altools" ] || [ "{aBranch}" == "both" ]; then                  # .(41115.02b.15)
#    cd "${aRepos}/AnyLLM_prod1-master"                                                 # .(41115.02d.51 RAM)
     aDir="AnyLLM"; if [ "${mARGs[2]}" != "" ];  then aDir="${mARGs[2]}"; fi            # .(41115.02f.1)
     if [ ! -d "${aRepos}/${aDir}" ]; then                                              # .(41115.02f.2)
        echo -e "* Invalid Repository folder, ${aDir}."                                 # .(41115.02f.3)
        exit_wCR                                                                        # .(41115.02f.4)
        fi                                                                              # .(41115.02f.5)
     cd "${aRepos}/${aDir}";  # echo "pwd: $( pwd )"; exit                              # .(41115.02f.6 RAM Gotta be in the repo folder).(41115.02d.52 RAM)
#    gitr update altools ALTools_prod1 "${aArgFlags}"                                   ##.(41116.03.4).(41115.02d.25)
#    git checkout master || exit 1;                                                     ##.(41115.02d.26 RAM Cute way to fail gracefully)
   if [ "${bDoit}" != "1" ]; then                                                       # .(41115.02d.53 RAM Honor bDoit)
#    git checkout master; if [ $? -ne 0 ]; then echo "checkout failed"; exit 1; fi      ##.(41115.02f.7).(41115.02d.27).(41204.05.1)
#    git branch -D altools                                                              ##.(41115.02f.8).(41115.02d.28 RAM Delete ALTools branch).(41204.05.1)
#    gitr delete branch altools                                                         ##.(41204.05.1).(41115.02d.28 RAM Delete ALTools branch)
     echo "  FRT install ALTools ${mARGs[2]} -u"
     frt install ALTools "${mARGs[2]}" -u                                               # .(41115.02d.54).(41115.02d.26 RAM Reinstall it)
   else                                                                                 # .(41115.02d.55)
     git checkout master; if [ $? -ne 0 ]; then echo "checkout failed"; exit 1; fi      # .(41115.02d.27).(41204.05.1)
     git branch -D altools                                                              # .(41115.02d.28 RAM Delete ALTools branch).(41204.05.1)
#    gitr delete branch altools                                                         ##.(41204.05.1).(41115.02d.28 RAM Delete ALTools branch)
     frt install ALTools "${mARGs[2]}" -du                                              # .(41115.02d.26 RAM Reinstall it)
     fi                                                                                 # .(41115.02d.56)
     end_wCR                                                                            # .(41204.03..4)
     echo -e "  --------------------------------------------------------------------------------------------------"
     bOK=1; fi                                                                          # .(41115.02b.16)

   if [ "${aBranch}" == "master"  ] || [ "{aBranch}" == "both" ]; then                  # .(41115.02b.17)
#    cd "${aRepos}"                                                                     ##.(41115.02e.x RAM)
     if [ -d "${aRepos}/AnyLLM"               ]; then cd "${aRepos}/AnyLLM"; fi         # .(41115.02e.xx Beg)
     if [ -d "${aRepos}/AnyLLM_prod1-master"  ]; then cd "${aRepos}/AnyLLM_prod1-master";  fi
     if [ -d "${aRepos}/AnyLLM_/prod1-master" ]; then cd "${aRepos}/AnyLLM_/prod1-master"; fi
     if [ -d "${aRepos}/AnyLLM_/AnyLLM_prod1-master" ]; then cd "${aRepos}/AnyLLM_/AnyLLM_prod1-master";  fi
                                                                                        # .(41115.02e.xx End)
     gitr update master "${aArgFlags}"                                                                      # .(41116.03.5)
     end_wCR                                                                            # .(41204.03..4)
     echo -e "  --------------------------------------------------------------------------------------------------"
     bOK=1; fi                                                                          # .(41115.02b.18)

   if [ "${bOK}" != "1" ]; then                                                       # .(41115.02b.19)
#    aMsg="Invalid";       if [ "${mARGs[1]}" == "" ]; then aMsg="Please provide a"; fi ##.(41115.02c.22).(41115.02c.24)
#    aBra=": ${mARGs[1]}"; if [ "${mARGs[1]}" == "" ]; then aBra=""; fi                 ##.(41115.02c.23).(41115.02c.24)
        if [ "${mARGs[1]}" == "" ]; then                                                # .(41115.02c.24 RAM Change for no branch Beg)
           echo -e "\n* Please provide a branch name: master, altools or both"
         else
           echo -e "\n* Invalid branch name: ${mARGs[1]}. S.B master, altools or both"  # .(41115.02b.20)
           fi                                                                           # .(41115.02c.24 End)
     fi                                                                                 # .(41115.02b.21)
     exit_wCR
     fi # eoc update                                                                    # .(41115.02.3 End)
# ---------------------------------------------------------------------------

    echo ""
 if [ "${aStage}" == "$(pwd)" ]; then
#if [ "${aStage}" == "" ]; then
    echo "* You are not in a ${aProj/_\//}_/{Stage} Git Repository"
    exit_wCR
  else
    echo "  RepoDir is: ${aRepoDir}"; #  exit_wCR
    fi # eif "${aStage}" == "$(pwd)"
# ---------------------------------------------------------------------------

  if [ "${aCmd}" == "setup" ]; then

     cd "${aRepoDir}"
#    echo "  pwd: '${aRepoDir}'"
#    echo -e "\nanyllm setup\n"                                                              ##.(41201.06.1 )
     echo -e "\nyarn setup for AnythingLLM\n"                                                # .(41201.06.1 RAM Echo setup command)
     yarn setup
     fi
# ---------------------------------------------------------------------------

  if [ "${aCmd}" == "copyEnvs" ]; then
#    echo "  aRepoDir:  '${aRepoDir}'"; echo "  cp -p \"${aRepoDir}/collector/.env.example\""; # exit
     echo ""
     echo "  copying ./collector/.env.example to ./collector/.env ($(  ls -l ./collector/.env | awk '{ print $6" "$7" "$8"  "$5" bytes" }' ))"
     cp -p "${aRepoDir}/collector/.env.example"          "${aRepoDir}/collector/.env"
     echo "  copied  ./collector/.env.example to ./collector/.env ($(  ls -l ./collector/.env | awk '{ print $6" "$7" "$8"  "$5" bytes" }' ))"
     echo ""
     echo "  copying ./frontend/.env.example  to ./frontend/.env  ($(  ls -l ./frontend/.env  | awk '{ print $6" "$7" "$8"  "$5" bytes" }' ))"
     cp -p "${aRepoDir}/frontend/.env.example"           "${aRepoDir}/frontend/.env"
     echo "  copied  ./frontend/.env.example  to ./frontend/.env  ($(  ls -l ./frontend/.env  | awk '{ print $6" "$7" "$8"  "$5" bytes" }' ))"
             setIPAddr                                                                  # .(41114.02.2)
     echo ""
     echo "  copying ./server/.env.development.example to ./server/.env.development ($(  ls -l ./server/.env.development | awk '{ print $6" "$7" "$8"  "$5" bytes" }' ))"
     cp -p "${aRepoDir}/server/.env.development.example" "${aRepoDir}/server/.env.development"
     echo "  copied  ./server/.env.development.example to ./server/.env.development ($(  ls -l ./server/.env.development | awk '{ print $6" "$7" "$8"  "$5" bytes" }' ))"
     fi
# ---------------------------------------------------------------------------

  if [ "${aCmd}" == "startApp" ]; then
     aApp="";
  if [ "${aArg3:0:1}" == "c" ] || [ "${aArg3:0:2}" == "-c" ]; then aApp="collector"; fi
  if [ "${aArg3:0:1}" == "f" ] || [ "${aArg3:0:2}" == "-f" ]; then aApp="frontend";  fi
  if [ "${aArg3:0:1}" == "s" ] || [ "${aArg3:0:2}" == "-s" ]; then aApp="server";    fi
  if [ "${aArg3:0:1}" == "a" ] || [ "${aArg3:0:2}" == "-a" ]; then aApp="all";       fi # .(41030.02.1)

  if [ "${aApp}" == "" ]; then echo -e "\n* Please provide an {App}: c, f or s"; exit_wCR; fi

  if [ "${aApp}" == "all" ]; then                                                       # .(41030.02.2 RAM Move em to here)
     cd "${aRepoDir}/collector" && npm start &
     cd "${aRepoDir}/frontend"  && npm start &
     cd "${aRepoDir}/server"    && npm start
     exit_wCR
   else                                                                                 # .(41030.02.3)
     cd "${aRepoDir}/${aApp}"
     npm start
     fi                                                                                 # .(41030.02.4)
     fi
# ---------------------------------------------------------------------------

# if [ "${aCmd}" == "showPorts" ]; then showPorts; fi                                   ##.(41201.02.1)
  if [ "${aCmd}" == "showPorts" ]; then jpt show ports; fi                              # .(41201.02.1 RAM)

  if [ "${aCmd}" == "killPort" ]; then
#    echo "  \$1: '$1', \$2: '$3', \$2: '$3', aArg2: '${aArg3}'"; # exit
#    echo "  \${mARGs[0]}: '${mARGs[0]}', \${mARGs[1]}: '${mARGs[1]}', \${mARGs[2]}: '${mARGs[2]}', \${mARGs[3]}: '${mARGs[3]}', \${mARGs[4]}: '${mARGs[4]}'"; # exit
     nPort=${mARGs[1]}; if [ "${aArg2}" == "por" ]; then nPort=${mARGs[2]}; fi          # .(41201.02.2 RAM Was == "port")
  if [ "${nPort}" == "" ]; then echo -e "\n* Please provide a port number"; exit_wCR; fi
#    echo "  Args: '$@', aArg2: ${aArg2} nPort: ${nPort}"; exit
     killPort ${nPort}
     fi
# ---------------------------------------------------------------------------

  if [ "${aCmd}" == "stopApp" ]; then
     nPort="";
  if [ "${aArg3:0:1}" == "c" ] || [ "${aArg3:0:2}" == "-c" ]; then nPort="8888"; fi
  if [ "${aArg3:0:1}" == "f" ] || [ "${aArg3:0:2}" == "-f" ]; then nPort="3000";  fi
  if [ "${aArg3:0:1}" == "s" ] || [ "${aArg3:0:2}" == "-s" ]; then nPort="3001";    fi
  if [ "${aArg3:0:1}" == "a" ] || [ "${aArg3:0:2}" == "-a" ]; then
     killPort 3000
     killPort 8888
     killPort 3001
     exit_wCR
     fi
  if [ "${nPort}" == "" ]; then echo -e "\n* Please provide an {App}: c, f or s"; exit_wCR; fi
     killPort ${nPort}
     fi # eoc stopApp
# ---------------------------------------------------------------------------

     exit_wCR
