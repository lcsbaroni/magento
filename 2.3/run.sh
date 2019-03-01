#! /bin/ash

echo `/sbin/ip route|awk '/default/ { print $3 }'`" docker.local" >> /etc/hosts
exec /sbin/runsvdir -P /etc/service/
