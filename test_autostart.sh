#!/bin/bash

echo "=== TESTE AUTOSTART ===" > /tmp/test_autostart.log
echo "Data: $(date)" >> /tmp/test_autostart.log
echo "DISPLAY: $DISPLAY" >> /tmp/test_autostart.log
echo "XDG_CURRENT_DESKTOP: $XDG_CURRENT_DESKTOP" >> /tmp/test_autostart.log

# Testar se o sistema tray está disponível
echo "Testando sistema tray..." >> /tmp/test_autostart.log
if pgrep -f awesome > /dev/null; then
    echo "AwesomeWM está rodando" >> /tmp/test_autostart.log
else
    echo "AwesomeWM NÃO está rodando" >> /tmp/test_autostart.log
fi

# Testar nm-applet
echo "Testando nm-applet..." >> /tmp/test_autostart.log
if pgrep nm-applet > /dev/null; then
    echo "nm-applet já está rodando" >> /tmp/test_autostart.log
else
    echo "Tentando iniciar nm-applet..." >> /tmp/test_autostart.log
    nm-applet &
    sleep 2
    if pgrep nm-applet > /dev/null; then
        echo "nm-applet iniciado com sucesso" >> /tmp/test_autostart.log
    else
        echo "ERRO: nm-applet falhou ao iniciar" >> /tmp/test_autostart.log
    fi
fi

echo "=== FIM TESTE ===" >> /tmp/test_autostart.log
