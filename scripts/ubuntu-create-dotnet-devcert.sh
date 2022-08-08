#!/bin/sh
SKIP_CLEANUP=1
. "$(dirname "$0")/common.sh"


usage() {
    echo "Usage: $0 [-s]"
    echo "Generates a valid ASP.NET Core self-signed certificate for the local machine."
    echo "The certificate will be imported into the system's certificate store and into various other places."
    echo "  -o: Output mode. Skips the cleanup of the generated folder."
    exit 1
}

while getopts "sh" opt
do
    case "$opt" in
        o)
            SKIP_CLEANUP=0
            ;;
        h)
            usage
            exit 1
            ;;
        *)
            ;;
    esac
done

$SUDO rm /etc/ssl/certs/dotnet-devcert.pem
$SUDO cp $CRTFILE "/usr/local/share/ca-certificates"
$SUDO update-ca-certificates

if [ "$SKIP_CLEANUP" = 1 ]; then
   cleanup
fi