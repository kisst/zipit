#!/bin/bash

sys_r=$(wc -l < /root/system-requirements.txt)
pip_r=$(wc -l < /root/pip-requirements.txt)
package_name=$1

if [ "$sys_r" -ne "0" ]
then
  echo -e "\e[7m[BUILD]\e[27m Install system packages"
  yum install -y $(cat /root/system-requirements.txt) || exit 0
else
  echo -e "\e[7m[ERROR]\e[27m Check the system-requirements.txt,"
  echo "you need at least zip and pip"
fi
if [ "$pip_r" -ne "0" ]
then
  echo -e "\e[7m[BUILD]\e[27m Install pip packages"
  mkdir /root/packages
  pip-3.6 install -r /root/pip-requirements.txt -t /root/packages || exit 0
else
  echo "Empty pip-requirements.txt you can use inline script as well"
fi

echo -e "\e[7m[BUILD]\e[27m Remove old build"
rm -fr /root/"$package_name".zip

echo -e "\e[7m[BUILD]\e[27m Zip it up"
pushd /root/packages
zip -r9 /root/"$package_name".zip .
popd

pushd /root/
zip -g "$package_name.zip" "$package_name".py
popd

echo -e "\e[7m[BUILD]\e[27m Clean it up"
rm -fr /root/packages
