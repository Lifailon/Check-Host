#!/bin/bash
case $1 in
"-t" | "--type")
    case $2 in
    "ping" | "dns" | "http" | "tcp" | "udp")
        type=$2
        host=$3
        count=$4
        node=$5
        if [[ ! -n $host ]]
        then
            echo "Invalid hostname."
            exit
        fi
        if [[ ! -n "$count" || ! $count =~ ^[0-9]+$ ]]
        then
            count=1
            node=$4
        fi
        if [ -n "$node" ]
        then
            check=$(curl -s -H "Accept: application/json" \
            "https://check-host.net/check-$type?host=https://$host&max_nodes=$count&node=$node" | jq .)
        else
            check=$(curl -s -H "Accept: application/json" \
            "https://check-host.net/check-$type?host=https://$host&max_nodes=$count" | jq .)
        fi
        request_id=$(printf "%s\n" "${check[@]}" | jq ".request_id" | sed 's/"//g')
        result=$(curl -s -H "Accept: application/json" "https://check-host.net/check-result/$request_id")
        while [[ $result == *null* ]]
        do
            result=$(curl -s -H "Accept: application/json" "https://check-host.net/check-result/$request_id")
            sleep 0.1
        done
        echo $result | jq .
    ;;
    *)
    echo -e "Invalid type.\nUse type: ping, dns, http, tcp, udp"
    ;;
    esac
;;
"-n" | "--nodes")
    curl -s -H "Accept: application/json" https://check-host.net/nodes/hosts | jq .nodes | \
    jq 'to_entries[] | {hostname: .key, location: .value.location[2]}'
;;
*)
    echo -e "Invalid parameter.\nUse parameters: <-t|--type>, <-n|--nodes>"
;;
esac

# Examples:
# netcheck -n
# netcheck -t ping yandex.ru
# netcheck -t ping yandex.ru us1.node.check-host.net
# netcheck -t dns yandex.ru
# netcheck -t http yandex.ru 5
# netcheck -t tcp yandex.ru:443
# netcheck -t tcp yandex.ru:22
# netcheck -t udp yandex.ru:443