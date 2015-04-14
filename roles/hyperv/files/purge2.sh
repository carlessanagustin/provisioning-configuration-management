#!/bin/sh
 
# Credits to:
#  - http://vstone.eu/reducing-vagrant-box-size/
#  - https://github.com/mitchellh/vagrant/issues/343
#  - https://gist.github.com/adrienbrault/3775253

## for vagrant related tasks, uncomment vagrant comments
 
# vagrant: Unmount project
#printf "STEP: vagrant: Unmount project\n"
#umount /vagrant
 
# Remove APT cache
printf "STEP: Remove APT cache\n"
apt-get clean -y
apt-get autoclean -y
 
# Zero free space to aid VM compression
printf "STEP: Zero free space to aid VM compression\n"
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
 
# Remove APT files
printf "STEP: Zero free space to aid VM compression\n"
find /var/lib/apt -type f | xargs rm -f
 
# Remove documentation files
printf "STEP: Remove documentation files\n"
find /var/lib/doc -type f | xargs rm -f
 
# vagrant: Remove Virtualbox specific files
#printf "STEP: vagrant: Remove Virtualbox specific files\n"
#rm -rf /usr/src/vboxguest* /usr/src/virtualbox-ose-guest*
 
# Remove Linux headers
printf "STEP: Remove Linux headers\n"
rm -rf /usr/src/linux-headers*
 
# Remove Unused locales (edit for your needs, this keeps only en* and pt_BR)
printf "STEP: Remove Unused locales (edit for your needs, this keeps only en* and pt_BR)
find\n" 
find /usr/share/locale/{af,am,ar,as,ast,az,bal,be,bg,bn,bn_IN,br,bs,byn,ca,cr,cs,csb,cy,da,de,de_AT,dz,el,en_AU,en_CA,eo,es,et,et_EE,eu,fa,fi,fo,fr,fur,ga,gez,gl,gu,haw,he,hi,hr,hu,hy,id,is,it,ja,ka,kk,km,kn,ko,kok,ku,ky,lg,lt,lv,mg,mi,mk,ml,mn,mr,ms,mt,nb,ne,nl,nn,no,nso,oc,or,pa,pl,ps,qu,ro,ru,rw,si,sk,sl,so,sq,sr,sr*latin,sv,sw,ta,te,th,ti,tig,tk,tl,tr,tt,ur,urd,ve,vi,wa,wal,wo,xh,zh,zh_HK,zh_CN,zh_TW,zu} -type d -delete
 
# Remove bash history
printf "STEP: Remove bash history\n"
unset HISTFILE
rm -f /root/.bash_history

# vagrant: Remove bash history
#printf "STEP: vagrant: Remove bash history\n"
#rm -f /home/vagrant/.bash_history
 
# Cleanup log files
printf "STEP: Cleanup log files\n"
find /var/log -type f | while read f; do echo -ne '' > $f; done;
 
# Whiteout root
printf "STEP: Whiteout root\n"
count=`df --sync -kP / | tail -n1  | awk -F ' ' '{print $4}'`;
count=$((count -= 1))
dd if=/dev/zero of=/tmp/whitespace bs=1024 count=$count;
rm /tmp/whitespace;
 
# Whiteout /boot
printf "STEP: Whiteout /boot\n"
count=`df --sync -kP /boot | tail -n1 | awk -F ' ' '{print $4}'`;
count=$((count -= 1))
dd if=/dev/zero of=/boot/whitespace bs=1024 count=$count;
rm /boot/whitespace;
 
# Whiteout swap 
printf "STEP: Whiteout swap\n"
swappart=`cat /proc/swaps | tail -n1 | awk -F ' ' '{print $1}'`
swapoff $swappart;
dd if=/dev/zero of=$swappart;
mkswap $swappart;
swapon $swappart;