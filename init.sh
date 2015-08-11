git submodule init
git submodule update
git submodule foreach git checkout master
git submodule foreach git pull origin master
git submodule foreach git fetch origin

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
	echo -e "\t -t Lttng-tools git id (commit/branch)" 1>&2
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

pushd userspace_rcu
git checkout $git_userspace_rcu
popd

pushd babeltrace
git checkout $git_babeltrace
popd

pushd lttng-modules
git checkout $git_modules
popd

pushd lttng-ust
git checkout $git_lttng_ust
popd

pushd lttng-ust
git checkout $git_lttng_tools
popd
