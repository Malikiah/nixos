#!/run/current-system/sw/bin/bash

OBJECT="$1"
OPERATION="$2"

if [[ $OBJECT == "DarwinKVM" ]]; then
	case "$OPERATION" in
        	"prepare")
                systemctl start libvirt-nosleep@"$OBJECT"  2>&1 | tee -a /var/log/libvirt/custom_hooks.log
                /etc/libvirt/hooks/vfio-startup 2>&1 | tee -a /var/log/libvirt/custom_hooks.log
                ;;

                "release")
                systemctl stop libvirt-nosleep@"$OBJECT"  2>&1 | tee -a /var/log/libvirt/custom_hooks.log
                /etc/libvirt/hooks/vfio-teardown 2>&1 | tee -a /var/log/libvirt/custom_hooks.log
                ;;
	esac
fi
