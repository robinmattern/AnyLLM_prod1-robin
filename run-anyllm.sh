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
##FD   run-anyllm.sh            |       |               |      |
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
# .(41016.01 10/16/24 RAM  9:23a|
# .(41016.01 10/16/24 RAM 10:10a|
# .(41016.01 10/21/24 RAM  8:12a|
# .(41016.01 10/22/24 RAM  4:55p|
# .(41016.01 10/23/24 RAM  8:37a|
# .(41109.07 11/09/24 RAM  4:10p| Add this heading
# .(41109.08 11/09/24 RAM  4:30p| Get remote for origin only
# .(41109.09 11/09/24 RAM  6:10p| Write show ports for Windows
# .(41111.06 11/09/24 RAM  7:08p| Allow anyllm to run from anywhere
# .(41112.03 11/12/24 RAM  8:30a| Add version and source
# .(41114.02 11/14/24 RAM 10:30a| Write and use setIPAddr for frontend .env
#
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
     echo "    Version            Show Version and Location"                            # .(41112.03.1)
#    echo ""
     exit_wCR
     }
# ---------------------------------------------------------------------------

function exit_wCR() {
  if [ "${aOS}" == "darwin" ]; then echo ""; fi
# if [ "$1" == "exit" ]; then exit; fi
     exit
     }
# ---------------------------------------------------------------------------

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

function getBinVersion() {                                                                                  # .(41112.01.1 RAM Write getBinVersion Beg)
  aBinFile="$( cat "${aBinDir}/$1" | awk '/\.sh/ { sub( /"\$.+/, "" ); sub( /^ */, "" ); sub( / *$/, "" ); print }' )"
# aBinFile="$( cat "${aBinDir}/$1" | awk '/\.sh/' )"; echo "  '${aBinFile}'"; exit
  aBinVer="$(  cat "${aBinFile}"   | awk '/ aVer="v[0-9]/ { sub( /aVer=/, "" ); a = $1 }; END{ print a }' )"
  }                                                                                                         # .(41112.01.1 End)
# -----------------------------------------------------------

 function getRepoDir() {
#  aBranch="$( git branch | awk '/\*/ { print substr($0,2) }' )"
#  echo "AnyLLM[ 90] "
   aRepos="$( echo "$(pwd)"       | awk '{ match($0, /.*[Rr][Ee][Pp][Oo][Ss]/); print substr($0,1,RLENGTH) }' )";
#  aRepo="$( git remote -v        | awk '/push/         { sub( /.+\//, ""); sub( /\.git.+/, "" ); print }' )"     # .(41109.08.1)
   aRepo="$( git remote -v        | awk '/origin.+push/ { sub( /.+\//, ""); sub( /\.git.+/, "" ); print }' )"     # .(41109.08.1 RAM Just for origin ??)
#  echo "AnyLLM[ 94]  aRepo: ${aRepo}"
#  aProjDir="${aRepoDir%%_*}"
#  aProjDir="$( echo "$(pwd)"     | awk '{ sub( "'${aRepoDir}'", "" ); print }' )"
#  aAWK='{ sub( "'${aRepos//\//\/}'/", "" ); sub( /[\/_].*/, "_"); print }';                echo "  aAWK:    '${aAWK}'"  # double up /s
   aAWK='{ sub( "'${aRepos}'/", "" );  sub( /_\/*.+/, "" ); sub( /\/.+/, "" ); print }';  # echo "  aAWK:    '${aAWK}'"  # .(41109.08.2 RAM awk: cmd. line:1: warning: escape sequence `\/' treated as plain `/')
#  aAWK='{ sub( "'${aRepos}'/", "" );  sub( "_/*.+",  "" ); sub( "/.+",  "" ); print }';    echo "  aAWK:    '${aAWK}'"  ##.(41109.08.2
   aProject="$( echo "$(pwd)"     | awk "${aAWK}" )" 2>/dev/null
#  echo "AnyLLM[101]  aProject: ${aProject}"

   aStgDir="$(  echo "$(pwd)"     | awk '{ sub( "'.+${aProject}'", "" ); print }' )"
#  aStage="$(   echo "${aStgDir}" | awk '{ sub( "^[_\/]+"        , "" ); print }' )"   ##.(41109.08.3 RAM awk: cmd. line:1: warning: escape sequence `\/' treated as plain `/')
   aStage="$(   echo "${aStgDir}" | awk '{ sub( "^[_/]+"         , "" ); print }' )"   # .(41109.08.3)
#  echo "AnyLLM[105]  aStage:    '${aStage}'"; # exit

   aRepoDir="${aRepos}/${aProject}${aStgDir}"
   if [ "${aRepo}" == "" ]; then aRepo="${aProject}${aStgDir}"; fi

   if [ "test" == "text" ]; then
   echo "  aRepos:   '${aRepos}'"
   echo "  aRepo:    '${aRepo}'"
   echo "  aProject: '${aProject}'"
   echo "  aStage:   '${aStage}'"
   echo "  aRepoDir: '${aRepoDir}'"
   exit_wCR
   fi
   }
# ---------------------------------------------------------------------------
   IPv4 Address. . . . . . . . . . . :

function get_subnet_ip() {
   local pattern=$1
   for ip in "${ips[@]}"; do
       if [[ $ip =~ $pattern ]]; then
           echo "$ip"
           return 0
       fi
   done
   return 1
   }

function setIPAddr() {                                                                  #.(41114.02.1 RAM Write setIPAddr)
   if [ "${aOS}" != "windows" ]; then
         mapfile -t ips < <( ifconfig | awk '/inet/ { print substr( $0, 40 )}' )
       else
         mapfile -t ips < <( ipconfig | awk '/IPv4/ { print substr( $0, 40 )}' )
         fi
         aIPAddr="$( get_subnet_ip "^192\.168\." || \
                     get_subnet_ip "^10\.0\.0\." || \
                     get_subnet_ip "^172\."      || \
                              echo  "127.0.0.1" )"
       echo "  Setting ./frontend/.env IP Address to ${aIPAddr}"
       sed -i "/^[[:space:]]*SERVER_IP=/ c\  SERVER_IP=${aIPAddr}" ./frontend/.env
       }                                                                                #.(41114.02.1 End)
# ---------------------------------------------------------------------------

function showPorts() {
  if [ "${aOS}" != "windows" ]; then                                                                        # .(41109.09.1)
    echo -e "\n  PID    IPAddr:Port      Program          "                                                 # .(41109.09.2)
    echo      "  -----  ---------------  -----------------"                                                 # .(41109.09.3)
#   lsof -i -P -n | grep LISTEN | awk '{ printf "  %-15s %6d   %s\n", $1, $2, $9 }'
    lsof -i -P -n | grep LISTEN | awk '{ printf "  %-6s %6d %-16s %s\n", $9, $2, $1 }'                      # .(41109.09.4)
  else                                                                                                      # .(41109.09.5 RAM Write show ports for Windows Beg)
    echo -e "\n  PID    IPAddr:Port      Program          "
    echo      "  -----  ---------------  -----------------"
#   netstat -ano | grep LISTEN | grep node | \

# First, get your arrays (but modified to actually capture the output)
    mapfile -t array1 < <( wmic process where "name='node.exe'" get commandline | awk 'NR>1 { split( $0, a, " "); gsub( /"/, "", a[2]); print a[2] "..." a[ length(a)-1 ] }' )
    mapfile -t array2 < <( wmic process where "name='node.exe'" get processid   | awk 'NR>1 { print $1 }' )

#   for i in "${!array1[@]}"; do echo "  $i: ${array1[$i]}"; done
#   echo      "  -----  ---------------  -----------------"
#   for i in "${!array2[@]}"; do echo "  $i: $( netstat -ano | grep "${array2[$i]}" | awk '{ a = $2; exit }; END{ print a ? a : "n/a" }' )"; done # combine them
#   echo      "  -----  ---------------  -----------------"

    for i in "${!array2[@]}"; do array3[$i]="${array2[$i]} $( netstat -ano | grep "${array2[$i]}" | awk '{ a = $2; exit }; END{ print a ? a : "n/a" }' ) ${array1[$i]}"; done # combine them
#   for i in "${!array3[@]}"; do     echo "  ${array3[$i]}" | awk '{ a=$1; b=$2; c=$3; if (c == "") { a = "."; b=$1; c=$2 }; printf "  %-6s %-16s %s\n", a, b, c }'; done                     # Print the combined array
    for i in "${!array3[@]}"; do     echo "  ${array3[$i]}" | awk '$3 != "..." { a=$1; b=$2; c=$3; printf "  %-6s %-16s %s\n", a, b, c }'; done                     # Print the combined array

#   ps -W | grep node | \
#   while read line; do
#       winpid=$( echo $line | awk '{print $1}')
#       gitpid=$( echo $line | awk '{print $4}')
#       port=$( netstat -ano | grep $gitpid | awk '{print $2}')
#       echo " | awk '{ printf "  %-15s %6d   %s\n", $1, $2, $9 }'
#       awk -F, '{ gsub("\"","",$0); split( $2, a, "node.exe"$2,  ); printf "%-6s %s\n", $1, a[2]}'
#       echo "Port: $port  Git Bash PID: $gitpid"
#   done
    echo -e "\n  To kill a Windows PID, do this: taskkill //F //PID {PID}"
    fi                                                                                                      # .(41109.09.5 End)
    exit_wCR
    }
# ---------------------------------------------------------------------------

 function killPort() {
     if [ $# -eq 0 ] || [ "$1" == "all" ]; then
         echo -e "\n  Usage: killport <port_number>\n"
     else
         local port="$1"
         local pid=$(lsof -t -i:"$port")
         if [ -z "$pid" ]; then
             echo -e "\n* No process found running on port $port"
         else
             echo -e "\n  Killing process $pid running on port $port"
             kill "$pid"
         fi
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

    setOSvars
    getRepoDir

    echo ""
 if [ "${aStage}" == "$(pwd)" ]; then
#if [ "${aStage}" == "" ]; then
    echo "* You are not in a ${aProj/_\//}_/{Stage} Git Repository"
    exit_wCR
  else
    echo "  RepoDir is: ${aRepoDir}"; #  exit_wCR
    fi
# ---------------------------------------------------------------------------

          aArg1=$1; aArg2=$2; aArg3=$3;  aCmd="help"
  if [ "${aArg1:0:5}" == "setup" ]; then aCmd="setup";  fi
  if [ "${aArg1:0:3}" == "ver"   ]; then aCmd="version";  fi                            # .(411112.03.2)

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

  if [ "${aArg1:0:3}" == "kil" ];                                then aCmd="killPort";   fi
  if [ "${aArg1:0:3}" == "kil" ] && [ "${aArg2:0:3}" == "por" ]; then aCmd="killPort";   fi
  if [ "${aArg1:0:3}" == "sho" ] && [ "${aArg2:0:3}" == "por" ]; then aCmd="showPorts";  fi

# ---------------------------------------------------------------------------

  if [ "${aCmd}" == "help" ]; then help; fi

# ---------------------------------------------------------------------------

  if [ "${aCmd}" == "version" ]; then
     getBinVersion "anyllm"                                                             # .(41112.03.2 RAM Use it)
     echo ""                                                                            # .(41112.03.3)
     echo "  anyllm Version:  ${aBinVer}"                                               # .(41112.03.4 RAM Display it)
     echo "  anyllm Script:    ${aBinDir}/anyllm"                                       # .(41112.03.5)
     echo "  anyllm Location: '${aBinFile}'"                                            # .(41112.03.6)
     fi
# ---------------------------------------------------------------------------

  if [ "${aCmd}" == "setup" ]; then
     cd "${aRepoDir}"
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
             setIPAddr                                                                  #.(41114.02.2)
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

  if [ "${aCmd}" == "showPorts" ]; then showPorts; fi

  if [ "${aCmd}" == "killPort" ]; then
     nPort=${aArg2}; if [ "${nPort}" == "port" ]; then nPort=${aArg3}; fi
  if [ "${nPort}" == "" ]; then echo -e "\n* Please provide a port number"; exit_wCR; fi
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
     fi
# ---------------------------------------------------------------------------

     exit_wCR
