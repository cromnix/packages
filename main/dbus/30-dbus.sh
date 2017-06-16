#!/bin/bash

# launches a session dbus instance

if [ -z "${DBUS_SESSION_BUS_ADDRESS}" ] && type dbus-launch >/dev/null; then
	if [ -n "$command" ]; then
		command="dbus-launch --exit-with-session $command"
	else
		eval `dbus-launch --sh-syntax --exit-with-session`
	fi
fi
