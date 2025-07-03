# AwesomeWM Configuration

Configuração modular e organizada do AwesomeWM com foco em produtividade e portabilidade.

## 🚀 Instalação Rápida

### **Script Automático (Recomendado):**
```bash
# Verificar dependências
./check-deps.sh

# Instalação completa (inclui configuração automática do Picom)
./install.sh

# Demo das funcionalidades
./demo.sh
```

### **Instalação Manual:**
Consulte `INSTALACAO.md` para instruções detalhadas.

## Características

- **Portável**: Usa variáveis dinâmicas baseadas no usuário atual (`$HOME`, `$USER`)
- **Modular**: Estrutura organizada em módulos separados
- **Auto-configuração**: Picom configurado automaticamente durante a instalação
- **Inteligente**: Lógica automática para posicionamento de aplicações
- **Widgets Avançados**: CPU, RAM, Rede e Volume em tempo real
- **Scratchpads**: Janelas flutuantes rápidas (Terminal, Calculadora, Notas)
- **Scripts de Produtividade**: Backup automático e monitoramento de recursos
- **Tema Moderno**: Transparências, cantos arredondados e cores dinâmicas

## Estrutura

```
~/.config/awesome/
├── rc.lua                    # Arquivo principal
├── install.sh                # 🆕 Script de instalação automática
├── check-deps.sh             # 🆕 Verificador de dependências
├── demo.sh                   # 🆕 Demonstração das funcionalidades
├── bin/                      # Scripts executáveis
│   ├── audio_manager         # 🎵 Gerenciador de áudio avançado
│   ├── bluetooth_audio_helper # 🎧 Helper para áudio Bluetooth
│   ├── brightness_control    # Controle de brilho
│   ├── logout               # Opções de energia
│   ├── rofi_change_display  # Opções de display
│   ├── backup_config        # 🆕 Backup automático da configuração
│   ├── wallpaper_manager    # 🖼️ Gerenciador de wallpapers
│   ├── set_default_wallpaper # Wallpaper padrão
│   ├── picom_manager        # 🎭 Gerenciador do Picom
│   ├── keep_picom_alive     # Monitor do Picom
│   ├── debug_autostart      # 🔍 Debug do autostart
│   ├── test_autostart       # 🧪 Teste dos applets
│   └── force_autostart      # 🚀 Força início das aplicações
├── config/
│   ├── error-handling.lua    # Tratamento de erros
│   ├── variables.lua         # Variáveis globais e configurações
│   ├── rules.lua            # Regras de janelas
│   ├── signals.lua          # Sinais e eventos
│   ├── autostart.lua        # Aplicações que iniciam automaticamente
│   ├── scratchpads.lua      # 🆕 Configuração de scratchpads
│   ├── keys/
│   │   ├── global.lua       # Atalhos globais
│   │   ├── client.lua       # Atalhos de cliente
│   │   └── client-buttons.lua # Botões do mouse
│   └── ui/
│       ├── menu.lua         # Menu principal
│       ├── wibar.lua        # Barra superior
│       ├── notifications.lua # Configuração de notificações
│       └── widgets/         # 🆕 Widgets da wibar
│           ├── cpu.lua      # Widget de CPU
│           ├── memory.lua   # Widget de RAM
│           ├── network.lua  # Widget de rede
│           └── volume.lua   # Widget de volume
└── themes/
    └── custom/              # Tema personalizado
```

## Tags Personalizadas

- 󰨞 **Tag 1**: Editor (Nvim/VSCode) + Terminal (primeiro terminal)
- 󰒱 **Tag 2**: Chat (Slack)  
- 󰖟 **Tag 3**: Browser (Chrome - sessão trabalho)
- 󰍹 **Tag 4**: Terminal (ícone de terminal)
- 󰉋 **Tag 5**: Arquivos (Nautilus)
- 󰝚 **Tag 6**: Música
- 󰊻 **Tag 7**: Documentos
- 󰟴 **Tag 8**: Configurações
- 󰐃 **Tag 9**: Diversos

### Lógica Inteligente de Terminais
- **Primeiro terminal**: Abre obrigatoriamente na Tag 1 (junto com editor)
- **Terminais subsequentes**: Abrem na tag atual (onde o usuário estiver)

## Atalhos Principais

### Aplicações
- `Super + Return`: Terminal
- `Super + b`: Browser (Chrome)
- `Super + e`: Gerenciador de arquivos (Nautilus)
- `Super + d`: Rofi launcher
- `Super + r`: Prompt de comando
- `Super + p`: Menubar
- `Super + x`: Prompt Lua

### Navegação
- `Super + 1-9`: Mudar para tag
- `Super + Shift + 1-9`: Mover janela para tag
- `Super + Ctrl + 1-9`: Toggle tag display
- `Super + Ctrl + Shift + 1-9`: Toggle tag on focused client
- `Super + j/k`: Navegar entre janelas
- `Super + Shift + j/k`: Trocar posição das janelas
- `Super + Left/Right`: Navegar entre tags
- `Super + Escape`: Voltar à tag anterior
- `Super + Tab`: Voltar ao cliente anterior
- `Super + u`: Pular para cliente urgente
- `Super + w`: Mostrar menu principal

### Layout
- `Super + Space`: Próximo layout
- `Super + Shift + Space`: Layout anterior
- `Super + l/h`: Aumentar/diminuir largura master
- `Super + Shift + l/h`: Aumentar/diminuir número de clientes master
- `Super + Ctrl + l/h`: Aumentar/diminuir número de colunas

### Cliente
- `Super + f`: Toggle fullscreen
- `Super + Shift + c`: Fechar janela
- `Super + Ctrl + Space`: Toggle floating
- `Super + Ctrl + Return`: Mover para master
- `Super + o`: Mover para outra tela
- `Super + t`: Toggle keep on top
- `Super + n`: Minimizar
- `Super + m`: Maximizar
- `Super + Ctrl + m`: Maximizar verticalmente
- `Super + Shift + m`: Maximizar horizontalmente

### Tela
- `Super + Ctrl + j/k`: Focar próxima/anterior tela

### Sistema
- `Super + Ctrl + r`: Reiniciar AwesomeWM
- `Super + Shift + q`: Sair do AwesomeWM
- `Super + s`: Mostrar ajuda de atalhos
- `Super + Ctrl + n`: Restaurar cliente minimizado

### My Managements (Atalhos Personalizados)
- `XF86AudioRaiseVolume`: Aumentar volume (+5%)
- `XF86AudioLowerVolume`: Diminuir volume (-5%)
- `XF86AudioMute`: Alternar mudo
- `XF86MonBrightnessUp`: Aumentar brilho (+10%)
- `XF86MonBrightnessDown`: Diminuir brilho (-10%)
- `Ctrl + 1`: Opções de display (rofi_change_display)
- `Super + Ctrl + l`: Opções de energia (logout)
- `Super + Shift + a`: Gerenciador de áudio (seleção de dispositivos)
- `Super + Ctrl + a`: Toggle Bluetooth/áudio interno
- `Super + Shift + b`: Backup da configuração

### Produtividade (Fase 2) 🆕
#### Wallpaper
- `Super + Ctrl + w`: Wallpaper aleatório
- `Super + Ctrl + Shift + w`: Escolher wallpaper por padrão
- `Super + Alt + w`: Restaurar wallpaper padrão (Samurai Yellow) 🆕

#### Compositor (Picom) 🆕 - Sempre Ativo
- Picom roda automaticamente em background
- Efeitos visuais sempre ativos (transparências, cantos arredondados)
- Monitoramento automático para manter sempre funcionando

### Scratchpads (Janelas Flutuantes Rápidas)
- `Alt + 1`: Terminal dropdown (estilo Quake)
- `Alt + 2`: Calculadora flutuante
- `Alt + 3`: Notas rápidas (nvim)

### Widgets na Wibar
- **CPU**: Mostra uso da CPU com cores (verde/amarelo/vermelho)
- **RAM**: Mostra uso da memória com percentual
- **Network**: Mostra velocidade de download/upload
- **Temperature**: Mostra temperatura do sistema
- **Battery**: Mostra status da bateria (se disponível)
- **Volume**: Mostra volume atual com controle por mouse
  - Clique: alternar mudo
  - Scroll: ajustar volume

## Aplicações Auto-inicializadas

1. **Nvim** (Tag 1) - delay 3s
2. **Slack** (Tag 2) - delay 6s  
3. **Chrome** (Tag 3) - delay 10s com perfil de trabalho

### System Applets (delay 5s+):
- **nm-applet**: Gerenciador de rede
- **blueman-applet**: Gerenciador de Bluetooth
- **pasystray**: Controle de áudio no system tray

### 🔧 Troubleshooting Autostart:

```bash
# Verificar status das aplicações
./bin/debug_autostart

# Testar applets manualmente
./bin/test_autostart

# Reiniciar apenas os applets
pkill nm-applet blueman-applet pasystray
sleep 2
nm-applet & blueman-applet & pasystray &
```

## Personalização

Para modificar as configurações, edite os arquivos em `config/`:
- `variables.lua`: Aplicações e configurações básicas
- `autostart.lua`: Apps que iniciam automaticamente
- `keys/global.lua`: Atalhos de teclado
- `rules.lua`: Regras de posicionamento de janelas
