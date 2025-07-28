# AwesomeWM Configuration

Configuração modular e otimizada do AwesomeWM com foco em produtividade.

## 🚀 Instalação

```bash
# Verificar dependências
./check-deps.sh

# Instalação completa
./install.sh

# Demo das funcionalidades
./demo.sh
```

## 📁 Estrutura

```
~/.config/awesome/
├── rc.lua                    # Arquivo principal
├── config/
│   ├── variables.lua         # Variáveis e tags
│   ├── autostart.lua         # Apps que iniciam automaticamente
│   ├── rules.lua             # Regras de janelas
│   ├── signals.lua           # Sinais e eventos
│   ├── scratchpads.lua       # Janelas flutuantes rápidas
│   ├── keys/                 # Atalhos de teclado
│   └── ui/                   # Interface (wibar, menu, widgets)
├── bin/                      # Scripts executáveis
└── themes/custom/            # Tema personalizado
```

## 🏷️ Tags

- 󰨞 **Tag 1**: Editor (Nvim/VSCode)
- 󰒱 **Tag 2**: Chat (Slack)  
- 󰖟 **Tag 3**: Browser (Chrome)
- 󰆍 **Tag 4**: Terminal
- 󰉋 **Tag 5**: Arquivos (Nautilus)
- 󰍹 **Tag 6**: Comunicação (Telegram/Discord)
- 󰊻 **Tag 7**: Documentos
- 󰟴 **Tag 8**: Configurações
- 󰐃 **Tag 9**: Diversos

## ⌨️ Atalhos Principais

### Aplicações
- `Super + Return`: Terminal
- `Super + b`: Browser
- `Super + e`: Arquivos
- `Super + d`: Rofi launcher

### Navegação
- `Super + 1-9`: Mudar para tag
- `Super + j/k`: Navegar entre janelas
- `Super + Left/Right`: Navegar entre tags
- `Super + Tab`: Cliente anterior

### Layout
- `Super + Space`: Próximo layout
- `Super + l/h`: Ajustar largura master
- `Super + f`: Fullscreen

### Sistema
- `Super + Ctrl + r`: Reiniciar AwesomeWM
- `Super + s`: Ajuda de atalhos

### Áudio
- `Super + Shift + a`: Gerenciador de áudio
- `Super + Ctrl + a`: Toggle Bluetooth/interno
- `XF86Audio*`: Controles de volume

### Scratchpads
- `Alt + Ctrl + 1`: Terminal dropdown
- `Alt + Ctrl + 2`: Calculadora
- `Alt + Ctrl + 3`: Notas

### Wallpaper
- `Super + Ctrl + w`: Wallpaper aleatório
- `Super + Alt + w`: Wallpaper padrão

## 🔧 Scripts

- **audio_manager**: Seleção visual de dispositivos de áudio
- **bluetooth_audio_helper**: Toggle automático Bluetooth
- **wallpaper_manager**: Gerenciamento de wallpapers
- **picom_manager**: Controle do compositor
- **backup_config**: Backup via git

## 🚀 Autostart

1. **Terminal + Nvim** (Tag 1) - 3s
2. **Slack** (Tag 2) - 6s  
3. **Chrome** (Tag 3) - 10s
4. **System Tray**: nm-applet, blueman-applet, pasystray - 5s+

## 📊 Widgets

- **CPU**: Uso com cores dinâmicas
- **RAM**: Percentual de memória
- **Network**: Velocidade up/down
- **Temperature**: Temperatura do sistema
- **Battery**: Status da bateria
- **Volume**: Controle por mouse

## 🎨 Características

- **Modular**: Estrutura organizada
- **Portável**: Variáveis dinâmicas
- **Auto-configuração**: Picom integrado
- **Widgets avançados**: Monitoramento em tempo real
- **Scratchpads**: Acesso rápido a ferramentas
- **Tema moderno**: Transparências e cantos arredondados
- **Git integrado**: Backup automático sem arquivos extras
