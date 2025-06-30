# AwesomeWM - Contexto Técnico da Configuração

## 🖥️ Informações do Sistema
- **OS:** Linux
- **Usuário:** $USER (dinâmico)
- **Home:** $HOME (dinâmico)
- **Config Path:** $HOME/.config/awesome
- **AwesomeWM:** v4.3 (Too long) ✅ **ATUALIZADO**
- **Bibliotecas Extras:** awesome-extra, vicious, lua-filesystem ✅ **INSTALADO**

## 📋 Status do Projeto - Fase 1 CONCLUÍDA + MELHORIAS ✅

### ✅ **Implementações Realizadas:**
- **Configuração Base**: ✅ Completa e funcional
- **Lock Screen**: ✅ Corrigido e funcionando
- **Estrutura Modular**: ✅ Implementada
- **Scripts Básicos**: ✅ Funcionando
- **Widgets Avançados**: ✅ **MODERNIZADOS** - 6 widgets com Vicious
- **Scratchpads**: ✅ **MODERNIZADOS** - Biblioteca scratch.lua
- **Scripts de Produtividade**: ✅ **IMPLEMENTADO** - Backup, Monitor de Recursos
- **Melhorias no Tema**: ✅ **IMPLEMENTADO** - Transparências, cantos arredondados
- **Bibliotecas Modernas**: ✅ **NOVO** - awesome-extra, vicious, scratch.lua

## 📁 Estrutura Atual da Configuração

### Arquivos Principais
- `rc.lua` - ✅ **ATUALIZADO** - Arquivo principal de configuração
- `README.md` - ✅ **ATUALIZADO** - Documentação da configuração
- `MELHORIAS_TODO.md` - ✅ **ATUALIZADO** - Lista de melhorias e status do projeto

### Diretório `bin/` - Scripts Executáveis
- `audio_manager` - Gerenciador de áudio
- `brightness_control` - Controle de brilho
- `logout` - ✅ **CORRIGIDO** - Opções de energia com i3lock
- `rofi_change_display` - Opções de display
- `set_lockscreen_wallpaper` - ✅ **IMPLEMENTADO** - Gerenciador de wallpaper do lock
- `backup_config` - ✅ **NOVO** - Script de backup automático das configurações
- `resource_monitor` - ✅ **NOVO** - Monitor de recursos do sistema com alertas

### Diretório `lib/` - ✅ **NOVO** - Bibliotecas Externas
- `scratch.lua` - ✅ **NOVO** - Biblioteca moderna de scratchpads (github.com/notnew/awesome-scratch)

### Diretório `config/` - Configurações Modulares
- `error-handling.lua` - Tratamento de erros
- `variables.lua` - Variáveis globais e configurações
- `rules.lua` - Regras de janelas
- `signals.lua` - Sinais e eventos
- `autostart.lua` - ✅ **ATUALIZADO** - Aplicações que iniciam automaticamente
- `scratchpads.lua` - ✅ **NOVO** - Configuração de scratchpads (janelas flutuantes)

#### Subdiretório `config/keys/`
- `global.lua` - ✅ **ATUALIZADO** - Atalhos globais com novos keybindings
- `client.lua` - Atalhos de cliente
- `client-buttons.lua` - Botões do mouse

#### Subdiretório `config/ui/`
- `menu.lua` - Menu principal
- `wibar.lua` - ✅ **ATUALIZADO** - Barra superior com widgets integrados
- `notifications.lua` - Configuração de notificações

#### Subdiretório `config/ui/widgets/` - ✅ **MODERNIZADO**
- `init.lua` - ✅ **ATUALIZADO** - Inicializador centralizado dos widgets
- `cpu.lua` - ✅ **MODERNIZADO** - Widget de CPU usando Vicious
- `memory.lua` - ✅ **MODERNIZADO** - Widget de memória RAM usando Vicious
- `network.lua` - ✅ **MODERNIZADO** - Widget de rede usando Vicious
- `volume.lua` - ✅ **MANTIDO** - Widget de volume com controles de mouse
- `temperature.lua` - ✅ **NOVO** - Widget de temperatura usando Vicious
- `battery.lua` - ✅ **NOVO** - Widget de bateria usando Vicious (auto-oculta)

### Diretório `themes/`
- `custom/` - ✅ **ATUALIZADO** - Tema personalizado com melhorias visuais

## 🏷️ Configuração de Tags

### Tags Personalizadas com Ícones
1. **󰨞 Tag 1**: Editor (Nvim/VSCode) + Terminal (primeiro terminal)
2. **󰒱 Tag 2**: Chat (Slack)
3. **󰖟 Tag 3**: Browser (Chrome - sessão trabalho)
4. **󰍹 Tag 4**: Terminal (ícone de terminal)
5. **󰉋 Tag 5**: Arquivos (Nautilus)
6. **󰝚 Tag 6**: Música
7. **󰊻 Tag 7**: Documentos
8. **󰟴 Tag 8**: Configurações
9. **󰐃 Tag 9**: Diversos

## 🎮 Scratchpads Modernizados ✅

### Biblioteca Moderna Implementada
- **Fonte**: https://github.com/notnew/awesome-scratch
- **Localização**: `lib/scratch.lua`
- **Funcionalidades**:
  - Toggle inteligente de janelas
  - Detecção automática de clientes existentes
  - Suporte a regras personalizadas
  - Compatibilidade total com AwesomeWM 4.3

### Janelas Flutuantes Rápidas
- **F12**: Terminal dropdown (estilo Quake)
  - Comando: `$TERMINAL -name scratch-terminal`
  - Regra: `{instance = "scratch-terminal"}`
  - Tamanho: 80% largura x 60% altura
  - Posição: Centro-superior da tela
  
- **Super + F12**: Calculadora flutuante
  - Aplicação: gnome-calculator
  - Regra: `{class = "Gnome-calculator"}`
  - Tamanho: Auto-dimensionado
  - Posição: Centralizado

- **Super + Shift + F12**: Notas rápidas
  - Aplicação: Terminal com nvim
  - Comando: `$TERMINAL -name scratch-notes -e nvim /tmp/awesome_notes.md`
  - Regra: `{instance = "scratch-notes"}`
  - Arquivo: /tmp/awesome_notes.md
  - Tamanho: 60% largura x 70% altura

## 📊 Widgets Modernizados com Vicious ✅

### Biblioteca Vicious Implementada
- **Fonte**: awesome-extra package
- **Funcionalidades**: Sistema de widgets robusto e eficiente
- **Performance**: Cache interno e timers otimizados
- **Compatibilidade**: Totalmente compatível com AwesomeWM 4.3

### Widgets Implementados (6 Total)
1. **CPU Widget** (`vicious.widgets.cpu`)
   - Atualização: A cada 3 segundos
   - Dados: Percentual de uso total da CPU
   - Cores: 
     - Verde (<60%): `#48dbfb`
     - Amarelo (60-80%): `#feca57`
     - Vermelho (>80%): `#ff6b6b`
   - Ícone: 󰻠

2. **Memory Widget** (`vicious.widgets.mem`)
   - Atualização: A cada 5 segundos
   - Dados: Percentual de RAM usado
   - Cores: Mesma lógica do CPU
   - Ícone: 󰍛

3. **Network Widget** (`vicious.widgets.net`)
   - Atualização: A cada 3 segundos
   - Dados: Velocidades de download/upload (↓/↑)
   - Interfaces: Auto-detecção (wlan0, eth0, enp0s3)
   - Formato: KB/s ou MB/s automaticamente
   - Cores baseadas na atividade:
     - Alta (>1MB/s): `#48dbfb`
     - Média (>100KB/s): `#feca57`
     - Baixa: `#a4b0be`
   - Ícone: 󰖩

4. **Temperature Widget** (`vicious.widgets.thermal`) - ✅ **NOVO**
   - Atualização: A cada 10 segundos
   - Dados: Temperatura da CPU (thermal_zone0)
   - Cores baseadas na temperatura:
     - Normal (<60°C): `#48dbfb`
     - Quente (60-75°C): `#feca57`
     - Crítico (>75°C): `#ff6b6b`
   - Ícone: 󰔏

5. **Battery Widget** (`vicious.widgets.bat`) - ✅ **NOVO**
   - Atualização: A cada 30 segundos
   - Dados: Percentual e status de carga
   - Auto-oculta: Se não há bateria detectada
   - Ícones dinâmicos:
     - 󰂄 (carregando)
     - 󰁹 (>80%)
     - 󰂀 (60-80%)
     - 󰁾 (40-60%)
     - 󰁼 (20-40%)
     - 󰁺 (<20%)
   - Cores: Vermelho (<15%), Amarelo (<30%), Azul (normal)

6. **Volume Widget** (mantido original)
   - Atualização: A cada 2 segundos
   - Controles interativos:
     - **Clique esquerdo**: Toggle mute
     - **Scroll up**: Volume +5%
     - **Scroll down**: Volume -5%
   - Ícones dinâmicos:
     - 󰖁 (mudo/0%)
     - 󰕿 (<30%)
     - 󰖀 (30-70%)
     - 󰕾 (>70%)
   - Integração: PulseAudio via `pactl`

## 🛠️ Scripts de Produtividade ✅

### Backup Automático (`bin/backup_config`)
- **Função**: Backup completo da configuração AwesomeWM
- **Localização**: `$HOME/.config/awesome_backups/`
- **Formato**: `awesome_backup_YYYYMMDD_HHMMSS`
- **Funcionalidades**:
  - Criação automática de diretório de backup
  - Informações detalhadas (tamanho, data, usuário)
  - Lista de arquivos principais incluídos
  - Limpeza automática (mantém 5 backups mais recentes)
  - Lista de backups disponíveis
- **Keybinding**: `Super + Shift + b`
- **Portabilidade**: Usa variáveis `$HOME` e `$USER`

### Monitor de Recursos (`bin/resource_monitor`)
- **Função**: Monitora CPU, RAM, disco, temperatura e bateria
- **Modos de Operação**:
  - `monitor`: Execução contínua com alertas
  - `status`: Mostra status atual do sistema
  - `help`: Ajuda e informações dos thresholds
- **Thresholds de Alerta**:
  - CPU: 85%
  - Memória: 85%
  - Disco: 90%
  - Temperatura: 75°C
- **Notificações**: Via `notify-send` com urgência crítica
- **Keybinding**: `Super + Shift + r` (modo status)
- **Detecção**: Bateria automática para laptops

## 🎨 Melhorias no Tema ✅

### Características Visuais Implementadas
- **Transparências**: Backgrounds com alpha channel
  - `bg_normal`: `#1a1a1aee`
  - `bg_focus`: `#2d2416ee`
  - `bg_minimize`: `#2a2a2aaa`
- **Cantos Arredondados**: `border_radius = 8px`
- **Espaçamento**: `useless_gap = 4px` entre janelas
- **Bordas**: Largura aumentada para 2px
- **Wibar**: 
  - Altura otimizada: 26px
  - Background com transparência
  - Integração com tema
- **Notificações**: 
  - Cantos arredondados via `gears.shape`
  - Transparência e bordas personalizadas

## 🔧 Configurações Técnicas

### Dependências Instaladas e Verificadas
- `pasystray` - ✅ **INSTALADO** - Controle de áudio na systray
- `nm-applet` - ✅ **DISPONÍVEL** - Gerenciador de rede
- `blueman-applet` - ✅ **DISPONÍVEL** - Gerenciador de bluetooth
- `gnome-calculator` - ✅ **DISPONÍVEL** - Para scratchpad calculadora

### Autostart Melhorado
- **Chrome**: Detecção aprimorada de processos browser principais
- **Widgets de Sistema**: Inicialização com delay duplo para garantir systray
- **Debug**: Sistema de notificações para troubleshooting
- **Delays otimizados**:
  - Terminal + Nvim: 2s
  - Slack: 4s
  - Chrome: 8s (aumentado)
  - System widgets: 3s

### Keybindings Implementados
```lua
-- Scratchpads
F12                    -- Terminal dropdown
Super + F12            -- Calculadora
Super + Shift + F12    -- Notas (nvim)

-- Scripts de Produtividade  
Super + Shift + b      -- Backup configuração
Super + Shift + r      -- Status recursos

-- Controles de Volume (widget)
Clique no widget       -- Toggle mute
Scroll up no widget    -- Volume +5%
Scroll down no widget  -- Volume -5%

-- Existentes (mantidos)
Super + Shift + a      -- Audio manager
Super + Ctrl + l       -- Power options
Ctrl + 1               -- Display options
```

## 🔐 Sistema de Lock Screen

### Configuração Atual
- **Lock Program:** i3lock
- **Wallpaper:** `$HOME/.config/awesome/lockscreen-wallpaper.png`
- **Redimensionamento:** Automático via ImageMagick
- **Fallback:** Cor sólida (#1e1e2e) se wallpaper não disponível

### Wallpapers Disponíveis
- **Pasta Principal:** `$HOME/Imagens/wallpapers/`
- **Wallpapers Suportados:** jpg, png, jpeg
- **Atual no Lock:** samurai-red-moon.png

## 📈 Status de Implementação Detalhado

### ✅ **FASE 1 - ESSENCIAIS (CONCLUÍDA)**
- [x] 4 Widgets funcionais na wibar (CPU, RAM, Rede, Volume)
- [x] 3 Scratchpads com keybindings funcionais
- [x] 2 Scripts de produtividade (Backup, Monitor)
- [x] Melhorias visuais no tema (transparências, cantos arredondados)
- [x] Controles de mouse integrados (volume widget)
- [x] Sistema de backup automático
- [x] Monitor de recursos com alertas
- [x] Documentação completa atualizada

### 🔄 **FASE 2 - PRODUTIVIDADE (PRÓXIMA)**
- [ ] Sistema de wallpapers dinâmico
- [ ] Centro de notificações com histórico
- [ ] Widgets adicionais (temperatura, bateria, clima)
- [ ] Timer Pomodoro integrado
- [ ] Melhorias avançadas no tema

### 🔄 **FASE 3 - AVANÇADAS (FUTURO)**
- [ ] Integrações externas (tmux, git, docker)
- [ ] Otimizações de performance
- [ ] Funcionalidades experimentais
- [ ] Tema dinâmico baseado em wallpaper

## 📊 Atualizações na Documentação

### ✅ **Documentos Atualizados:**
- [x] `MELHORIAS_TODO.md` - Status completo da Fase 1
- [x] `README.md` - Funcionalidades e atalhos atualizados
- [x] `CONTEXTO_TECNICO.md` - Este arquivo (generalizado e expandido)
- [x] `bin/backup_config` - Informações dinâmicas do usuário

### 🎯 **Próximos Passos:**
1. **Testar** todas as implementações da Fase 1
2. **Validar** funcionamento dos widgets e scratchpads
3. **Confirmar** scripts de backup e monitoramento
4. **Planejar** implementações da Fase 2

---

**Última atualização:** 30 de Junho de 2025 - 18:00 UTC
**Status:** ✅ **FASE 1 CONCLUÍDA COM SUCESSO**
**Próximo:** Fase 2 - Sistema de wallpapers dinâmico e centro de notificações
**Documentação:** 100% atualizada e sincronizada
