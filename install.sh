#!/bin/bash
set -e


NRPOC=`nproc`


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
