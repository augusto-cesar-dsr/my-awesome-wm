# AwesomeWM - Lista de Melhorias e ToDo

## 📋 Status do Projeto
- **Configuração Base**: ✅ Completa e funcional
- **Lock Screen**: ✅ Corrigido e funcionando
- **Estrutura Modular**: ✅ Implementada
- **Scripts Básicos**: ✅ Funcionando

---

## 🚀 Melhorias Planejadas

### 1. Sistema de Widgets Avançados na Wibar
**Prioridade: ALTA** 🔴
- [ ] Widget de CPU com gráfico em tempo real
- [ ] Widget de RAM com indicador visual
- [ ] Widget de temperatura do sistema
- [ ] Widget de rede com velocidade up/down
- [ ] Widget de bateria (se laptop) com estimativa
- [ ] Widget de volume com controle visual e ícones
- [ ] Widget de clima com API externa
- [ ] Widget de data/hora mais elaborado

**Arquivos a modificar:**
- `config/ui/wibar.lua`
- Criar: `config/ui/widgets/`

### 2. Gerenciamento de Wallpapers Dinâmico
**Prioridade: MÉDIA** 🟡
- [ ] Rotação automática de wallpapers por tempo
- [ ] Wallpapers diferentes por workspace/tag
- [ ] Integração wallpaper desktop + lock screen
- [ ] Script para download automático de wallpapers
- [ ] Configuração de horários (wallpaper diurno/noturno)

**Arquivos a criar:**
- `bin/wallpaper_manager`
- `config/wallpaper-config.lua`

### 3. Sistema de Notificações Melhorado
**Prioridade: MÉDIA** 🟡
- [ ] Centro de notificações com histórico
- [ ] Notificações personalizadas por aplicação
- [ ] Notificações de sistema (bateria baixa, rede, etc.)
- [ ] Integração com dunst ou naughty melhorado
- [ ] Notificações de produtividade (pomodoro, lembretes)

**Arquivos a modificar:**
- `config/ui/notifications.lua`
- Criar: `config/ui/notification-center.lua`

### 4. Scratchpads (Janelas Flutuantes Rápidas)
**Prioridade: ALTA** 🔴
- [ ] Terminal dropdown (estilo Quake)
- [ ] Calculadora rápida
- [ ] Notas rápidas/sticky notes
- [ ] Monitor de sistema flutuante
- [ ] Player de música flutuante

**Arquivos a criar:**
- `config/scratchpads.lua`
- `bin/scratchpad_manager`

### 5. Melhorias no Tema Visual
**Prioridade: ALTA** 🔴
- [ ] Tema mais moderno com cantos arredondados
- [ ] Sistema de transparências e blur
- [ ] Cores dinâmicas baseadas no wallpaper
- [ ] Animações suaves para transições
- [ ] Tema escuro/claro automático por horário
- [ ] Customização de bordas e sombras

**Arquivos a modificar:**
- `themes/custom/`
- Criar: `themes/dynamic/`

### 6. Scripts de Produtividade
**Prioridade: MÉDIA** 🟡
- [ ] Backup automático de configurações
- [ ] Monitor de recursos com alertas
- [ ] Gerenciador de projetos/workspaces
- [ ] Timer Pomodoro integrado
- [ ] Launcher de aplicações inteligente
- [ ] Sistema de bookmarks/favoritos

**Arquivos a criar:**
- `bin/backup_config`
- `bin/resource_monitor`
- `bin/project_manager`
- `bin/pomodoro_timer`

### 7. Integração com Ferramentas Externas
**Prioridade: BAIXA** 🟢
- [ ] Integração tmux melhorada (sessões, janelas)
- [ ] Controles de mídia (Spotify, YouTube, etc.)
- [ ] Integração com Git (status de repos)
- [ ] Integração com Docker (containers ativos)
- [ ] Integração com AWS CLI (status de recursos)
- [ ] Integração com calendário (Google Calendar)

**Arquivos a criar:**
- `config/integrations/`
- `bin/media_controls`
- `bin/git_status`

### 8. Otimizações de Performance
**Prioridade: BAIXA** 🟢
- [ ] Cache de configurações
- [ ] Lazy loading de módulos
- [ ] Otimização de widgets pesados
- [ ] Redução de uso de CPU/RAM
- [ ] Profiling e benchmarks

---

## 🛠️ Implementação Sugerida por Fases

### **Fase 1 - Essenciais** (1-2 sessões)
1. Widgets básicos na wibar (CPU, RAM, rede)
2. Scratchpad para terminal dropdown
3. Melhorias básicas no tema

### **Fase 2 - Produtividade** (2-3 sessões)
1. Sistema de wallpapers dinâmico
2. Centro de notificações
3. Scripts de backup e monitoramento

### **Fase 3 - Avançadas** (3-4 sessões)
1. Integrações externas
2. Otimizações de performance
3. Funcionalidades experimentais

---

## 📁 Estrutura de Arquivos Planejada

```
~/.config/awesome/
├── rc.lua
├── MELHORIAS_TODO.md          # Este arquivo
├── bin/
│   ├── logout                 # ✅ Implementado
│   ├── set_lockscreen_wallpaper # ✅ Implementado
│   ├── wallpaper_manager      # 🔄 Planejado
│   ├── scratchpad_manager     # 🔄 Planejado
│   ├── backup_config          # 🔄 Planejado
│   ├── resource_monitor       # 🔄 Planejado
│   ├── project_manager        # 🔄 Planejado
│   └── media_controls         # 🔄 Planejado
├── config/
│   ├── ui/
│   │   ├── wibar.lua          # 🔄 Para melhorar
│   │   ├── widgets/           # 🔄 Novo diretório
│   │   ├── notification-center.lua # 🔄 Planejado
│   │   └── scratchpads.lua    # 🔄 Planejado
│   ├── integrations/          # 🔄 Novo diretório
│   └── wallpaper-config.lua   # 🔄 Planejado
└── themes/
    ├── custom/                # ✅ Existente
    └── dynamic/               # 🔄 Planejado
```

---

## 🎯 Próximos Passos

Quando quiser continuar, podemos:

1. **Escolher uma prioridade** da lista acima
2. **Implementar fase por fase** seguindo a ordem sugerida
3. **Testar cada funcionalidade** antes de passar para a próxima
4. **Documentar as mudanças** neste arquivo

---

## 📝 Notas de Implementação

### Dependências Necessárias
- `imagemagick` - ✅ Instalado (para wallpapers)
- `curl` - Para widgets de clima/API
- `jq` - Para parsing JSON
- `dunst` - Para notificações avançadas
- `picom` - Para transparências/blur

### Configurações Atuais Funcionando
- ✅ Lock screen com wallpaper ajustado
- ✅ Tags com ícones personalizados
- ✅ Autostart inteligente de aplicações
- ✅ Estrutura modular organizada
- ✅ Scripts de gerenciamento de energia

### Backup Atual
Antes de implementar melhorias, sempre fazer:
```bash
cp -r ~/.config/awesome ~/.config/awesome.backup.$(date +%Y%m%d_%H%M%S)
```

---

**Última atualização:** $(date)
**Status:** Planejamento completo - Pronto para implementação
