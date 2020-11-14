Создайте bash скрипт, который собирает базовую информацию об аппаратной части, операционной системе и конфигурации
сетевых интерфейсов. В результате выполнения этого скрипта необходимо сформировать файл следующего содержания:

--- Hardware ---
CPU: Intel xeon 2675
RAM: xxxx 
System Serial Number: XXXXXX (здесь подразумевается вывод dmidecode -s system-serial-number)
--- System ---
OS Distribution: xxxxx (например Ubuntu 16.04.4 LTS)
Kernel version: xxxx (например 4.4.0-116-generic)
Installation date: xxxx
Hostname: yyyyy
Uptime: XX days
Processes running: 56684
Users logged in: 665
--- Network ---
<Iface #1 name>:  IP/mask
<Iface #2  name>:  IP/mask
…
<Iface #N  name>:  IP/mask

Дополнительные требования
В файле указанные разделы (т.е. Hardware, System, Network) и соответствующие параметры должны следовать строго 
в указанном порядке;

Скрипт должен корректно собирать информацию о настройке сетевых интерфейсов системы, независимо от их количества;

Для каждого интерфейса должна выводится информация об IP адресе и сетевой маске. Если для интерфейса не сконфигурирован
IP адрес, в соответствующей строке выводить “-”.

---------------------------------------------------------------------------------------------------------------------

#!/bin/bash

echo "----------Hardware----------"

echo "CPU:" $(lscpu | grep "Model name" | cut -d : -f 2)
#DMI (Desktop Management Interface) — интерфейс (API), позволяющий программному обеспечению собирать данные
#о характеристиках компьютера.
echo "RAM:" $(dmidecode -t memory | grep -i size | head -n 1 | cut -d : -f 2)
echo "Serial Number": $(dmidecode -s system-serial-number)

echo "----------System----------"

echo "OS Distribution:" $(lsb_release -d | cut -d : -f 2)
echo "Kernel version:" $(uname -r)
echo "Installation date:" $(ls -alct /|tail -1|awk '{print $6, $7, $8}')
echo "Hostname:" $(hostname -f)
echo "Uptime:" $(uptime -p | cut -d " " -f2-)
echo "Processes running:" $(ps aux | wc -l)
echo "User logged in:" $(users | wc -w)

echo "----------Network----------"

for intf in $(ls /sys/class/net); do
  intf_now=$(ip -o addr show $intf | wc -l)
if ((intf_now > 0)); then
  echo -e "$intf: \c"

#tr:
#-s - команда сжимает два или более последовательных пробелов в один пробел.

#paste:
#-d - сменить разделитель TAB на другой (список)
#-s - вместо того, чтобы выводить строки из файлов рядом друг с другом, они выводятся последовательно.

#sed:
#замена запятой на and

     ip -o -4 -a addr show $interface | tr -s ' ' | cut -d ' ' -f 4 | paste -d ',' -s | sed 's/,/ and /'
         else
             echo "$interface: -"
             fi
         done
