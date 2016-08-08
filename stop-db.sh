#!/bin/bash
set -e

echo "Stopping MySQL server..."
pidof mysqld | xargs kill
