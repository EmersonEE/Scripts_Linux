#!/bin/bash
export HYPRSOCKET=$(find /run/user/1000/hypr/ -name .hyprsunset.sock)
hyprsunset &
