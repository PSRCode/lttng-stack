#!/bin/bash
set -e


NRPOC=`nproc`
git_userspace_rcu=master
git_modules=master
git_babeltrace=master
git_lttng_ust=master
git_lttng_tools=master

usage() { 
	echo "Usage:"
	echo "$0 [-u git_id] [-m git_id] [-b git_id] [-s git_id] [-t git_id]" 1>&2
	echo "All option default to master"
	echo -e "\t -u Userspace-rcu git id (commit/branch)" 1>&2
	echo -e "\t -m Lttng-modules git id (commit/branch)" 1>&2
	echo -e "\t -b Babeltrace git id (commit/branch)" 1>&2
	echo -e "\t -s Lttng-ust git id (commit/branch)" 1>&2
	echo -e "\t -t Lttng-tools Userspace-rcu git id (commit/branch)" 1>&2
	exit 1
}

while getopts "u:m:b:s:t:" o; do
    case "${o}" in
        u)
            git_userspace_rcu=${OPTARG}
            ;;
        m)
            git_modules=${OPTARG}
            ;;
        b)
            git_babeltrace=${OPTARG}
            ;;
        s)
            git_lttng_ust=${OPTARG}
            ;;
        t)
            git_lttng_tools=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

git pull --recurse-submodules
git submodule update --recursive


echo "
##     ##  ######  ######## ########   ######  ########     ###     ######  ########         ########   ######  ##     ## 
##     ## ##    ## ##       ##     ## ##    ## ##     ##   ## ##   ##    ## ##               ##     ## ##    ## ##     ## 
##     ## ##       ##       ##     ## ##       ##     ##  ##   ##  ##       ##               ##     ## ##       ##     ## 
##     ##  ######  ######   ########   ######  ########  ##     ## ##       ######   ####### ########  ##       ##     ## 
##     ##       ## ##       ##   ##         ## ##        ######### ##       ##               ##   ##   ##       ##     ## 
##     ## ##    ## ##       ##    ##  ##    ## ##        ##     ## ##    ## ##               ##    ##  ##    ## ##     ## 
 #######   ######  ######## ##     ##  ######  ##        ##     ##  ######  ########         ##     ##  ######   #######  
 "


pushd userspace-rcu
git checkout $git_userspace_rcu
./bootstrap
./configure
make -j $NRPOC
sudo make install
sudo ldconfig
popd

echo "
##       ######## ######## ##    ##  ######           ##     ##  #######  ########  ##     ## ##       ########  ######  
##          ##       ##    ###   ## ##    ##          ###   ### ##     ## ##     ## ##     ## ##       ##       ##    ## 
##          ##       ##    ####  ## ##                #### #### ##     ## ##     ## ##     ## ##       ##       ##       
##          ##       ##    ## ## ## ##   #### ####### ## ### ## ##     ## ##     ## ##     ## ##       ######    ######  
##          ##       ##    ##  #### ##    ##          ##     ## ##     ## ##     ## ##     ## ##       ##             ## 
##          ##       ##    ##   ### ##    ##          ##     ## ##     ## ##     ## ##     ## ##       ##       ##    ## 
########    ##       ##    ##    ##  ######           ##     ##  #######  ########   #######  ######## ########  ######  
"

pushd lttng-modules
make -j $NPROC
sudo make modules_install
sudo depmod -a
popd


echo "
########     ###    ########  ######## ##       ######## ########     ###     ######  ######## 
##     ##   ## ##   ##     ## ##       ##          ##    ##     ##   ## ##   ##    ## ##       
##     ##  ##   ##  ##     ## ##       ##          ##    ##     ##  ##   ##  ##       ##       
########  ##     ## ########  ######   ##          ##    ########  ##     ## ##       ######   
##     ## ######### ##     ## ##       ##          ##    ##   ##   ######### ##       ##       
##     ## ##     ## ##     ## ##       ##          ##    ##    ##  ##     ## ##    ## ##       
########  ##     ## ########  ######## ########    ##    ##     ## ##     ##  ######  ######## 
"

pushd babeltrace
./bootstrap
./configure
make -j $NPROC
sudo make install
sudo ldconfig
popd


echo "
##       ######## ######## ##    ##  ######           ##     ##  ######  ######## 
##          ##       ##    ###   ## ##    ##          ##     ## ##    ##    ##    
##          ##       ##    ####  ## ##                ##     ## ##          ##    
##          ##       ##    ## ## ## ##   #### ####### ##     ##  ######     ##    
##          ##       ##    ##  #### ##    ##          ##     ##       ##    ##    
##          ##       ##    ##   ### ##    ##          ##     ## ##    ##    ##    
########    ##       ##    ##    ##  ######            #######   ######     ##    
"

pushd lttng-ust
./bootstrap
./configure
make -j $NPROC
sudo make install
sudo ldconfig
popd

echo "
##       ######## ######## ##    ##  ######           ########  #######   #######  ##        ######  
##          ##       ##    ###   ## ##    ##             ##    ##     ## ##     ## ##       ##    ## 
##          ##       ##    ####  ## ##                   ##    ##     ## ##     ## ##       ##       
##          ##       ##    ## ## ## ##   #### #######    ##    ##     ## ##     ## ##        ######  
##          ##       ##    ##  #### ##    ##             ##    ##     ## ##     ## ##             ## 
##          ##       ##    ##   ### ##    ##             ##    ##     ## ##     ## ##       ##    ## 
########    ##       ##    ##    ##  ######              ##     #######   #######  ########  ######  
"

pushd lttng-tools
./bootstrap
./configure
make -j $NPROC
sudo make install
sudo ldconfig
popd
