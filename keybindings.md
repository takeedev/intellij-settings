# IdeaVim Keybindings Reference (.ideavimrc)

เอกสารอธิบาย key mappings ทั้งหมดจากไฟล์ [`.ideavimrc`](https://github.com/takeedev/intellij-settings/blob/main/ideavim/.ideavimrc)

> **Leader key = `Space` (เว้นวรรค)** — ทุก mapping ที่เขียนว่า `<leader>` ให้กด Space ก่อน

---

## สารบัญ

- [การตั้งค่าพื้นฐาน (Settings)](#การตั้งค่าพื้นฐาน-settings)
- [Plugins ที่เปิดใช้](#plugins-ที่เปิดใช้)
- [Vim Dial](#vim-dial)
- [Vim AnyObject](#vim-anyobject)
- [Insert Mode](#insert-mode)
- [Multiple Cursors](#multiple-cursors)
- [การเลื่อน cursor และ scroll](#การเลื่อน-cursor-และ-scroll)
- [การจัดการหน้าต่าง (Window)](#การจัดการหน้าต่าง-window)
- [Navigation: VCS / Diff / Error](#navigation-vcs--diff--error)
- [Goto Navigation](#goto-navigation)
- [Marks](#marks)
- [`<leader>.` — Settings และ UI Toggles](#leader--settings-และ-ui-toggles)
- [`<leader>a` — เปิด Tool Windows](#leadera--เปิด-tool-windows)
- [`<leader>b` + ตัวเลข — Buffers](#leaderb--ตัวเลข--buffers)
- [`<leader>c` — Code / Config / Clear](#leaderc--code--config--clear)
- [`<leader>d` — Debug / Delete marks](#leaderd--debug--delete-marks)
- [`<leader>e` — Extract / Edit / Expand](#leadere--extract--edit--expand)
- [`<leader>f` — Find / Format](#leaderf--find--format)
- [`<leader>g` — Git / Goto / Generate](#leaderg--git--goto--generate)
- [`<leader>h` — Hide](#leaderh--hide)
- [`<leader>i` — Introduce / Inline](#leaderi--introduce--inline)
- [`<leader>j` — Quick Docs](#leaderj--quick-docs)
- [`<leader>k` — Keymap](#leaderk--keymap)
- [`<leader>l` — Local History](#leaderl--local-history)
- [`<leader>m` — Mode / View](#leaderm--mode--view)
- [`<leader>n` — New](#leadern--new)
- [`<leader>o` — Open / Optimize / Override](#leadero--open--optimize--override)
- [`<leader>p` — Popup / Project / Parameter Info](#leaderp--popup--project--parameter-info)
- [`<leader>q` — Quit](#leaderq--quit)
- [`<leader>r` — Run / Refactor / Replace](#leaderr--run--refactor--replace)
- [`<leader>s` — Search / Show / Step (Debug)](#leaders--search--show--step-debug)
- [`<leader>t` — Toggles / Tabs / Breakpoints](#leadert--toggles--tabs--breakpoints)
- [`<leader>u` — Unwrap / Pin Tab](#leaderu--unwrap--pin-tab)
- [`<leader>v` — VCS](#leaderv--vcs)
- [`<leader>w` — Windows](#leaderw--windows)
- [Leader อื่นๆ](#leader-อื่นๆ)
- [Education Plugin](#education-plugin)
- [Tabs](#tabs)
- [Visual Mode Surround](#visual-mode-surround)
- [Ctrl Key Handler (IDE vs Vim)](#ctrl-key-handler-ide-vs-vim)

---

## การตั้งค่าพื้นฐาน (Settings)

| Setting | ความหมาย |
|---|---|
| `set clipboard+=unnamedplus` | ใช้ clipboard ร่วมกับระบบปฏิบัติการ (yank/paste ข้าม app ได้) |
| `set ideajoin` | คำสั่ง `J` (join บรรทัด) ใช้ logic ของ IDE ที่ฉลาดกว่า |
| `set ignorecase` + `set smartcase` | ค้นหาไม่สนตัวพิมพ์เล็ก/ใหญ่ แต่ถ้าพิมพ์ตัวใหญ่จะ match แบบเป๊ะ |
| `set number` + `set relativenumber` | แสดงเลขบรรทัดจริง + เลขบรรทัดแบบ relative |
| `set visualbell` | ใช้การกระพริบหน้าจอแทนเสียงเตือน |
| `set notimeout` | ไม่จำกัดเวลารอกด key ต่อหลัง leader (popup which-key ค้างรอได้) |
| `let mapleader=" "` | กำหนด **Space** เป็น leader key |

## Plugins ที่เปิดใช้

| Plugin | ทำอะไร |
|---|---|
| `NERDTree` | ใช้คำสั่ง NERDTree ใน Project tool window (เช่น `o`, `j`, `k` ใน file tree) |
| `peekaboo` | แสดง popup รายการ registers เมื่อกด `"` หรือ `@` |
| `quickscope` | highlight ตัวอักษรเป้าหมายเวลาใช้ `f` / `F` / `t` / `T` |
| `sneak` | กด `s` + ตัวอักษร 2 ตัว เพื่อกระโดดไปตำแหน่งนั้น (`S` ค้นถอยหลัง) |
| `surround` | จัดการเครื่องหมายครอบข้อความ เช่น `cs"'` เปลี่ยน `"` เป็น `'`, `ds(` ลบวงเล็บ |
| `which-key` | แสดง popup รายการ key ที่กดต่อได้หลังกด leader |
| `multiple-cursors` | ใช้หลาย cursor พร้อมกัน (ดูหัวข้อ Multiple Cursors) |
| `dial` | เพิ่ม/ลดค่าตามความหมาย เช่น number, boolean, date และ Java keyword |
| `anyobject` | เพิ่ม text object ตามโครงสร้างโค้ด เช่น argument, method, class และ variable |

## Vim Dial

วาง cursor ไว้บนค่าหรือก่อนค่าที่ต้องการเปลี่ยน แล้วใช้:

| Key | ทำอะไร | ตัวอย่าง |
|---|---|---|
| `Space +` | เพิ่ม/วนไปค่าถัดไป | `false` → `true`, `private` → `protected`, วันที่วันถัดไป |
| `Space -` | ลด/วนกลับค่าก่อนหน้า | `true` → `false`, `protected` → `private`, วันที่วันก่อนหน้า |

ไม่ได้ใช้ค่าแนะนำเดิม `Ctrl+a` / `Ctrl+x` เพราะ key ทั้งสองมีหน้าที่อื่นใน config นี้อยู่แล้ว

## Vim AnyObject

ใช้ร่วมกับ operator ของ Vim เช่น `d` (ลบ), `c` (เปลี่ยน), `y` (คัดลอก) และ `v` (เลือก):

| Text object | เป้าหมาย | ตัวอย่าง |
|---|---|---|
| `ia` / `aa` | argument ด้านใน / รวม comma | `cia` เปลี่ยน argument, `daa` ลบ argument พร้อม separator |
| `if` / `af` | method หรือ function | `vif` เลือก body ของ method |
| `ic` / `ac` | class / interface | `vac` เลือก class ทั้งก้อน |
| `iv` / `av` | variable หรือ field | `yiv` คัดลอกค่าหรือ declaration |
| `iu` / `au` | subword ใน `camelCase` / `snake_case` | `ciu` เปลี่ยนเฉพาะ subword |
| `]a` / `[a` | กระโดดไป argument ถัดไป / ก่อนหน้า | ใช้ไล่ arguments โดยไม่ต้องค้นหา |

## Insert Mode

| Key | ทำอะไร |
|---|---|
| `jj` | ออกจาก Insert mode กลับ Normal mode (แทน `Esc`) |
| `Ctrl+j` | เลื่อน cursor ลง (ขณะพิมพ์) |
| `Ctrl+k` | เลื่อน cursor ขึ้น (ขณะพิมพ์) |

## Multiple Cursors

| Key | Mode | ทำอะไร |
|---|---|---|
| `Ctrl+n` | Normal/Visual | เลือกคำใต้ cursor แล้วเพิ่ม cursor ที่คำเดียวกันตัวถัดไป (ทั้งคำ) |
| `g` `Ctrl+n` | Normal/Visual | เหมือนข้างบน แต่ match แบบบางส่วนของคำได้ |
| `Ctrl+x` | Visual | ข้าม occurrence ปัจจุบัน ไปตัวถัดไป |
| `Ctrl+p` | Visual | ถอด cursor ล่าสุดออก (ย้อนกลับ) |
| `Ctrl+Shift+n` | Normal/Visual | เลือกทุก occurrence ของคำพร้อมกันทั้งไฟล์ |

## การเลื่อน cursor และ scroll

| Key | ทำอะไร |
|---|---|
| `n` / `N` | ไปผลการค้นหาถัดไป/ก่อนหน้า **พร้อมจัด cursor ให้อยู่กลางจอ** (`zzzv`) |
| `Ctrl+d` / `Ctrl+u` | เลื่อนลง/ขึ้นครึ่งหน้า **พร้อมจัด cursor ให้อยู่กลางจอ** |

## การจัดการหน้าต่าง (Window)

| Key | ทำอะไร |
|---|---|
| `Ctrl+h` / `Ctrl+j` / `Ctrl+k` / `Ctrl+l` | ย้าย focus ไป split ซ้าย / ล่าง / บน / ขวา |
| `-` | ขยาย split ลงด้านล่าง (StretchSplitToBottom) |
| `=` | ขยาย split ขึ้นด้านบน (StretchSplitToTop) |
| `_` | ขยาย split ไปทางซ้าย (StretchSplitToLeft) |
| `+` | ขยาย split ไปทางขวา (StretchSplitToRight) |

## Navigation: VCS / Diff / Error

| Key | ทำอะไร |
|---|---|
| `]c` / `[c` | ไป change marker (จุดที่แก้ไขใน git) ถัดไป / ก่อนหน้า |
| `]d` / `[d` | ไป diff ถัดไป / ก่อนหน้า |
| `]e` / `[e` | ไป error ถัดไป / ก่อนหน้า |

## Goto Navigation

| Key | Action | ทำอะไร |
|---|---|---|
| `gi` | GotoImplementation | กระโดดไป implementation |
| `gs` | GotoSuperMethod | กระโดดไป super method / parent class |
| `gt` / `gT` | GotoTest | สลับไปไฟล์ test ของ class นี้ |

## Marks

ทุก mark ตัวพิมพ์เล็ก (`ma`–`mz`) ถูก remap ให้ใช้ **mark ตัวพิมพ์ใหญ่** (`mA`–`mZ`) แทน
และการกระโดด `'a`–`'z` ก็ remap เป็น `'A`–`'Z` เช่นกัน

**ผลลัพธ์:** mark ใช้ได้ **ข้ามไฟล์** (global marks) โดยไม่ต้องกด Shift

| Key | ทำอะไร |
|---|---|
| `m` + ตัวอักษร | ตั้ง mark (global) ที่ตำแหน่งปัจจุบัน |
| `'` + ตัวอักษร | กระโดดไป mark นั้น (ข้ามไฟล์ได้) |
| `<leader>dm` | ลบ marks ทั้งหมด (0-9, A-Z) |

## `<leader>.` — Settings และ UI Toggles

| Key | Action | ทำอะไร |
|---|---|---|
| `Space . c` | ToggleCompactMode | เปิด/ปิด Compact mode |
| `Space . C` | CloseProject | ปิดโปรเจกต์ |
| `Space . d` | ToggleDistractionFreeMode | เปิด/ปิด Distraction Free mode |
| `Space . f` | ToggleFullScreen | เปิด/ปิด Full screen |
| `Space . k` | ChangeKeymap | เปลี่ยน keymap |
| `Space . l` | EditorToggleShowLineNumbers | เปิด/ปิดเลขบรรทัด |
| `Space . m` | ExternalSystem.ProjectRefreshAction | Reload โปรเจกต์ (Maven/Gradle sync) |
| `Space . p` | WelcomeScreen.Plugins | เปิดหน้า Plugins |
| `Space . r` | RunConfiguration | เปิด Run Configuration |
| `Space . R` | RestartIde | Restart IDE |
| `Space . s` | SettingsEntryPoint | เปิดเมนู Settings |
| `Space . t` | ChangeLaf | เปลี่ยน Theme (Look and Feel) |
| `Space . T` | ViewToolButtons | แสดง/ซ่อนปุ่ม tool window |
| `Space . z` | ToggleZenMode | เปิด/ปิด Zen mode |
| `Space . v` | — | เปิดไฟล์ `~/.ideavimrc` เพื่อแก้ไข |

## `<leader>a` — เปิด Tool Windows

| Key | ทำอะไร |
|---|---|
| `Space a b` | เปิด Bookmarks |
| `Space a B` | เปิด Build |
| `Space a c` | เปิด Commit |
| `Space a C` | เปิด Coverage |
| `Space a d` | เปิด Debug |
| `Space a D` / `Space a S` | เปิด Services |
| `Space a f` | เปิด Find |
| `Space a g` / `Space a v` | เปิด Version Control (Git) |
| `Space a G` | เปิด Gradle |
| `Space a h` | เปิด Hierarchy |
| `Space a i` | เปิด AI Assistant |
| `Space a k` | เปิด/ปิด Presentation Assistant (แสดง key ที่กดบนจอ) |
| `Space a m` | เปิด Maven |
| `Space a n` | เปิด Notifications |
| `Space a p` | เปิด Project (file tree) |
| `Space a P` | เปิด Problems |
| `Space a r` | เปิด Run |
| `Space a s` | เปิด Structure |
| `Space a t` | เปิด Terminal |
| `Space a T` | เปิด Task |
| `Space a w` | เปิด Git Working Trees |

## `<leader>b` + ตัวเลข — Buffers

| Key | ทำอะไร |
|---|---|
| `Space 1`–`Space 9` | กระโดดไป buffer หมายเลข 1–9 |
| `Space b [` / `Space b h` / `Space b p` | ไป buffer ก่อนหน้า |
| `Space b ]` / `Space b l` / `Space b n` | ไป buffer ถัดไป |
| `Space b d` / `Space b k` | ปิด buffer ปัจจุบัน (`:q`) |
| `Space b i` | แสดงรายการ buffer ทั้งหมด (`:ls`) |
| `Space b O` | ปิดทุก tab ยกเว้น tab ปัจจุบัน |

## `<leader>c` — Code / Config / Clear

| Key | Action | ทำอะไร |
|---|---|---|
| `Space c a` | ShowIntentionActions | แสดง quick fix / intention (เหมือน Alt+Enter) |
| `Space c d` | GotoDeclaration | กระโดดไป declaration |
| `Space c f` | ReformatCode | จัด format โค้ด |
| `Space c h` | CallHierarchy | แสดง call hierarchy |
| `Space c i` / `Space c o` | OptimizeImports | จัดระเบียบ imports |
| `Space c k` | ChangeKeymap | เปลี่ยน keymap |
| `Space c n` | ClearAllNotifications | ล้าง notifications ทั้งหมด |
| `Space c O` | CloseAllEditorsButActive | ปิดทุก tab ยกเว้นปัจจุบัน |
| `Space c p` | WelcomeScreen.Plugins | เปิดหน้า Plugins |
| `Space c r` | RenameElement | Rename (refactor) |
| `Space c R` | Refactorings.QuickListPopupAction | เปิดเมนู refactor ทั้งหมด |
| `Space c s` | SettingsEntryPoint | เปิด Settings |
| `Space c v` | — | เปิดไฟล์ `~/.ideavimrc` |

## `<leader>d` — Debug / Delete marks

| Key | Action | ทำอะไร |
|---|---|---|
| `Space d b` / `Space d e` | Debug | เริ่ม Debug |
| `Space d d` | ContextDebug | Debug ตาม context ปัจจุบัน (ไฟล์/test ที่ cursor อยู่) |
| `Space d m` | `:delmarks 0-9A-Z` | ลบ marks ทั้งหมด |

## `<leader>e` — Extract / Edit / Expand

| Key | Action | ทำอะไร |
|---|---|---|
| `Space e a` | ExpandAllRegions | กางโค้ดที่พับไว้ทั้งหมด |
| `Space e r` | ExpandRegion | กางโค้ดที่พับตรง cursor |
| `Space e c` | IntroduceConstant | Extract เป็น constant |
| `Space e f` | IntroduceField | Extract เป็น field |
| `Space e i` | ExtractInterface | Extract เป็น interface |
| `Space e m` | ExtractMethod | Extract เป็น method |
| `Space e p` | IntroduceParameter | Extract เป็น parameter |
| `Space e v` | IntroduceVariable | Extract เป็น variable |
| `Space e V` | refactoring.introduce.property | Extract เป็น property |
| `Space e I` / `Space e S` | ShowSettings | เปิด Settings |
| `Space e P` | ShowProjectStructureSettings | เปิด Project Structure |
| `Space e R` | editRunConfigurations | แก้ไข Run Configurations |

## `<leader>f` — Find / Format

| Key | Action | ทำอะไร |
|---|---|---|
| `Space f f` / `Space f p` | FindInPath | ค้นหาข้อความทั้งโปรเจกต์ |
| `Space f i` | Find | ค้นหาในไฟล์ปัจจุบัน |
| `Space f u` | FindUsages | หาที่ที่ใช้ symbol นี้ |
| `Space f r` | RecentFiles | ไฟล์ที่เปิดล่าสุด |
| `Space f m` / `Space f o` | ReformatCode | จัด format โค้ด |
| `Space f n` | NewElement | สร้างไฟล์/element ใหม่ |
| `Space f e` | RevealIn | เปิดตำแหน่งไฟล์ใน Finder/Explorer |
| `Space f s` | ToggleFullScreen | เปิด/ปิด Full screen |

## `<leader>g` — Git / Goto / Generate

| Key | Action | ทำอะไร |
|---|---|---|
| `Space g a` | Git.Add | `git add` |
| `Space g b` | Annotate | Git blame (annotate) |
| `Space g c` | CheckinProject | Commit |
| `Space g f` | Git.Fetch | `git fetch` |
| `Space g p` | Git.Pull | `git pull` |
| `Space g P` | Vcs.Push | `git push` |
| `Space g g` | ActivateVersionControlToolWindow | เปิดหน้าต่าง Git |
| `Space g h` | Vcs.ShowTabbedFileHistory | ประวัติ git ของไฟล์นี้ |
| `Space g l` | Vcs.Show.Log | Git log |
| `Space g w` | Git.Show.WorkingTrees | Git working trees |
| `Space g e` | Generate | เมนู Generate (constructor, getter/setter ฯลฯ) |
| `Space g i` | GotoImplementation | ไป implementation |
| `Space g s` | GotoSuperMethod | ไป super method |
| `Space g t` / `Space g T` | GotoTest | ไปไฟล์ test |

## `<leader>h` — Hide

| Key | ทำอะไร |
|---|---|
| `Space h` | ซ่อน tool windows ทั้งหมด |

## `<leader>i` — Introduce / Inline

| Key | Action | ทำอะไร |
|---|---|---|
| `Space i c` | IntroduceConstant | Extract เป็น constant |
| `Space i f` | IntroduceField | Extract เป็น field |
| `Space i p` | IntroduceParameter | Extract เป็น parameter |
| `Space i P` | refactoring.introduce.property | Extract เป็น property |
| `Space i v` | IntroduceVariable | Extract เป็น variable |
| `Space i l` / `Space i n` | Inline | Inline (ยุบ variable/method กลับเข้าที่ใช้) |
| `Space i m` | ImplementMethods | Implement methods จาก interface |
| `Space i d` | VimFindActionIdAction | หา Action ID ของ IDE (ไว้เขียน config เพิ่ม) |

## `<leader>j` — Quick Docs

| Key | Action | ทำอะไร |
|---|---|---|
| `Space j d` | QuickJavaDoc | แสดง documentation popup |
| `Space j i` | QuickImplementations | แสดง implementation popup |

## `<leader>k` — Keymap

| Key | ทำอะไร |
|---|---|
| `Space k` | เปลี่ยน keymap |

## `<leader>l` — Local History

| Key | Action | ทำอะไร |
|---|---|---|
| `Space l h` | LocalHistory.ShowHistory | ดู Local History ของไฟล์ |
| `Space l H` | LocalHistory.ShowSelectionHistory | ดู Local History ของส่วนที่เลือก |

## `<leader>m` — Mode / View

| Key | Action | ทำอะไร |
|---|---|---|
| `Space m c` | ToggleCompactMode | Compact mode |
| `Space m d` | ToggleDistractionFreeMode | Distraction Free mode |
| `Space m f` | ToggleFullScreen | Full screen |
| `Space m z` | ToggleZenMode | Zen mode |
| `Space m P` | TogglePresentationMode | Presentation mode |
| `Space m k` / `Space m p` | TogglePresentationAssistantAction | แสดง key ที่กดบนหน้าจอ |
| `Space m h` | ShowHoverInfo | แสดงข้อมูล hover ตรง cursor |
| `Space m t` | ViewToolButtons | แสดง/ซ่อนปุ่ม tool window |
| `Space m T` / `Space m w` | ViewToolBar | แสดง/ซ่อน toolbar |
| `Space m v` | ChangeView | เปลี่ยน view |

## `<leader>n` — New

| Key | Action | ทำอะไร |
|---|---|---|
| `Space n d` | NewDir | สร้างโฟลเดอร์ใหม่ |
| `Space n e` | NewElement | สร้าง element ใหม่ (เมนูเลือกชนิด) |
| `Space n f` | NewFile | สร้างไฟล์ใหม่ |
| `Space n p` | NewProject | สร้างโปรเจกต์ใหม่ |
| `Space n s` | Macro.NewScratchFile | สร้าง scratch file |
| `Space n t` | TerminalNewPredefinedSession | เปิด terminal session ใหม่ |

## `<leader>o` — Open / Optimize / Override

| Key | Action | ทำอะไร |
|---|---|---|
| `Space o f` / `Space o P` | OpenFile | เปิดไฟล์ |
| `Space o b` | OpenInBrowser | เปิดไฟล์ใน browser |
| `Space o e` | RevealIn | เปิดตำแหน่งไฟล์ใน Finder/Explorer |
| `Space o g` | Vcs.Log.OpenAnotherTabInEditor | เปิด git log ใน editor tab |
| `Space o i` | OptimizeImports | จัดระเบียบ imports |
| `Space o m` | OverrideMethods | Override methods |
| `Space o p` | ActivateProjectToolWindow | เปิด Project tool window |
| `Space o r` | RecentProjectListGroup | โปรเจกต์ล่าสุด |
| `Space o t` | Terminal.OpenInTerminal | เปิด terminal ที่ตำแหน่งไฟล์นี้ |

## `<leader>p` — Popup / Project / Parameter Info

| Key | Action | ทำอะไร |
|---|---|---|
| `Space p d` | QuickJavaDoc | Documentation popup |
| `Space p f` | GotoFile | ค้นหาไฟล์ตามชื่อ |
| `Space p h` | ShowHoverInfo | ข้อมูล hover |
| `Space p i` | QuickImplementations | Implementation popup |
| `Space p m` | ShowPopupMenu | เมนูคลิกขวา (context menu) |
| `Space p p` | ParameterInfo | แสดง parameter ของ method |
| `Space p r` | RunConfiguration | Run configuration |
| `Space p t` | PinActiveTabToggle | ปักหมุด/ถอดหมุด tab |

## `<leader>q` — Quit

| Key | ทำอะไร |
|---|---|
| `Space q` | ปิดหน้าต่าง/tab ปัจจุบัน (`:q`) |

## `<leader>r` — Run / Refactor / Replace

| Key | Action | ทำอะไร |
|---|---|---|
| `Space r r` | RunClass | Run class ปัจจุบัน |
| `Space r d` | DebugClass | Debug class ปัจจุบัน |
| `Space r u` | ChooseRunConfiguration | เลือก run configuration |
| `Space r a` | RunAnything | Run Anything (double Ctrl) |
| `Space r A` | RunnerActions | เมนู runner actions |
| `Space r m` | RunMenu | เมนู Run |
| `Space r s` | runShellFileAction | Run ไฟล์ shell script |
| `Space r c` | RunCoverage | Run พร้อม coverage |
| `Space r C` | Coverage | เมนู coverage |
| `Space r e` | Refactorings.QuickListPopupAction | เมนู refactor ทั้งหมด |
| `Space r n` | RenameElement | Rename |
| `Space r p` | Replace | แทนที่ในไฟล์ปัจจุบัน |
| `Space r w` | ReplaceInPath | แทนที่ทั้งโปรเจกต์ |
| `Space r b` | Vcs.RollbackChangedLines | ย้อนบรรทัดที่แก้ (rollback lines) |
| `Space r B` / `Space r o` | ChangesView.Revert | Revert การเปลี่ยนแปลง |
| `Space r f` | RecentFiles | ไฟล์ล่าสุด |
| `Space r l` | RecentLocations | ตำแหน่งล่าสุด |
| `Space r i` | RevealIn | เปิดใน Finder/Explorer |

## `<leader>s` — Search / Show / Step (Debug)

### Search / Goto

| Key | Action | ทำอะไร |
|---|---|---|
| `Space s a` | GotoAction | ค้นหา action ของ IDE |
| `Space s c` | GotoClass | ค้นหา class |
| `Space s f` | GotoFile | ค้นหาไฟล์ |
| `Space s s` | GotoSymbol | ค้นหา symbol |
| `Space s p` / `Space s t` | TextSearchAction | ค้นหาข้อความ |
| `Space s r` | ReplaceInPath | แทนที่ทั้งโปรเจกต์ |
| `Space s u` | ShowUsages | แสดงที่ที่ใช้ symbol นี้ (popup) |

### Show

| Key | Action | ทำอะไร |
|---|---|---|
| `Space s d` | QuickJavaDoc | Documentation popup |
| `Space s e` | ShowErrorDescription | รายละเอียด error ตรง cursor |
| `Space s h` | ShowHoverInfo | ข้อมูล hover |
| `Space s I` | ShowIntentionActions | Quick fix (Alt+Enter) |
| `Space s n` | ShowNavBar | แสดง navigation bar |
| `Space s m` / `Space s P` | ShowPopupMenu | เมนูคลิกขวา |
| `Space s k` | TogglePresentationAssistantAction | แสดง key บนจอ |
| `Space s H` | Vcs.ShowTabbedFileHistory | ประวัติ git ของไฟล์ |
| `Space s w` | SurroundWith | Surround with (try/catch, if ฯลฯ) |
| `Space s v` | `:source ~/.ideavimrc` | Reload config IdeaVim |
| `Space s G` / `Space s M` | ExternalSystem.ProjectRefreshAction | Sync Maven/Gradle |

### Debug Stepping

| Key | Action | ทำอะไร |
|---|---|---|
| `Space s i` | StepInto | Step into |
| `Space s o` | StepOver | Step over |
| `Space s O` | StepOut | Step out |
| `Space s T` | Stop | หยุดการ run/debug |

## `<leader>t` — Toggles / Tabs / Breakpoints

| Key | Action | ทำอะไร |
|---|---|---|
| `Space t b` | ToggleLineBreakpoint | เปิด/ปิด breakpoint บรรทัดนี้ |
| `Space t c` | ToggleCompactMode | Compact mode |
| `Space t f` | ToggleFullScreen | Full screen |
| `Space t z` | ToggleZenMode | Zen mode |
| `Space t k` | TogglePresentationAssistantAction | แสดง key บนจอ |
| `Space t h` | `:tabm -` | ย้าย tab ไปทางซ้าย |
| `Space t l` | `:tabm +` | ย้าย tab ไปทางขวา |
| `Space t n` | `:set number!` | เปิด/ปิดเลขบรรทัด |
| `Space t r` | `:set relativenumber!` | เปิด/ปิดเลขบรรทัด relative |
| `Space t t` | ViewToolButtons | ปุ่ม tool window |
| `Space t v` | VimPluginToggle | เปิด/ปิด IdeaVim ทั้งหมด |

## `<leader>u` — Unwrap / Pin Tab

| Key | Action | ทำอะไร |
|---|---|---|
| `Space u w` | Unwrap | ถอดโครงสร้างครอบออก (unwrap if/try ฯลฯ) |
| `Space u p` | PinActiveTabToggle | ปักหมุด tab |

## `<leader>v` — VCS

| Key | Action | ทำอะไร |
|---|---|---|
| `Space v c` | CheckinProject | Commit |
| `Space v p` | Git.Pull | Pull |
| `Space v P` | Vcs.Push | Push |
| `Space v h` | Vcs.ShowTabbedFileHistory | ประวัติไฟล์ |
| `Space v l` | Vcs.Show.Log | Git log |
| `Space v b` | ViewBreakpoints | ดู breakpoints ทั้งหมด |

## `<leader>w` — Windows

| Key | ทำอะไร |
|---|---|
| `Space w h/j/k/l` | ย้าย focus ไป split ซ้าย/ล่าง/บน/ขวา |
| `Space w s` | แยกหน้าจอแนวนอน (`:sp`) |
| `Space w v` | แยกหน้าจอแนวตั้ง (`:vs`) |
| `Space w c` / `Space w d` / `Space w q` | ปิดหน้าต่างปัจจุบัน (`:q`) |

## Leader อื่นๆ

| Key | ทำอะไร |
|---|---|
| `Space Enter` | แสดง intention actions (quick fix) |
| `Space Space` | สลับไปไฟล์ก่อนหน้า (alternate file, `Ctrl+^`) |
| `Space /` | comment/uncomment บรรทัดหรือส่วนที่เลือก |

## Education Plugin

(สำหรับคอร์สเรียนใน JetBrains Academy)

| Key | Action | ทำอะไร |
|---|---|---|
| `Space C` | Educational.Check | ตรวจคำตอบ |
| `Space N` | Educational.NextTask | ไป task ถัดไป |
| `Space P` | Educational.PreviousTask | ไป task ก่อนหน้า |
| `Space R` | Educational.RefreshTask | รีเซ็ต task |

## Tabs

| Key | ทำอะไร |
|---|---|
| `Tab` | ไป editor tab ถัดไป |
| `Shift+Tab` | ไป editor tab ก่อนหน้า |

## Visual Mode Surround

เลือกข้อความใน Visual mode แล้วกดเครื่องหมาย เพื่อครอบข้อความนั้นทันที (ใช้ plugin surround)

| Key | ผลลัพธ์ |
|---|---|
| `` ` `` | ครอบด้วย `` `...` `` |
| `'` | ครอบด้วย `'...'` |
| `"` | ครอบด้วย `"..."` |
| `(` หรือ `)` | ครอบด้วย `(...)` |
| `[` หรือ `]` | ครอบด้วย `[...]` |
| `{` หรือ `}` | ครอบด้วย `{...}` |

## Ctrl Key Handler (IDE vs Vim)

กำหนดว่า Ctrl แต่ละตัวให้ใครจัดการ (`sethandler`) — `a` = ทุก mode, `n` = normal, `i` = insert, `v` = visual

| Key | Handler | หมายเหตุ |
|---|---|---|
| `Ctrl+a` | IDE (ทุก mode) | เช่น select all ของ IDE |
| `Ctrl+b` | IDE (ทุก mode) | |
| `Ctrl+c` | Vim (insert/visual) | |
| `Ctrl+d` | IDE (insert) | normal mode ยังเป็น Vim (เลื่อนครึ่งหน้า) |
| `Ctrl+e` | IDE (ทุก mode) | Recent files ของ IDE |
| `Ctrl+f` | IDE (ทุก mode) | Find ของ IDE |
| `Ctrl+h` | Vim (normal) | ใช้ย้าย split |
| `Ctrl+i` | Vim (ทุก mode) | jump forward |
| `Ctrl+j` / `Ctrl+k` | Vim (normal) | ใช้ย้าย split |
| `Ctrl+l` | IDE (ทุก mode) | |
| `Ctrl+m` | IDE (ทุก mode) | |
| `Ctrl+n` | Vim (normal) | multiple cursors |
| `Ctrl+o` | Vim (ทุก mode) | jump back |
| `Ctrl+p` | Vim (normal) | |
| `Ctrl+r` | Vim (ทุก mode) | redo |
| `Ctrl+u` | Vim (ทุก mode) | เลื่อนขึ้นครึ่งหน้า |
| `Ctrl+v` | Vim (ทุก mode) | visual block |
| `Ctrl+w` | IDE (ทุก mode) | extend selection ของ IDE |
| `Ctrl+x` | Vim (ทุก mode) | |
| `Ctrl+[` | Vim (ทุก mode) | = Esc |
| `Ctrl+Shift+n` | Vim (ทุก mode) | select all occurrences |

---

*สร้างจากไฟล์ [.ideavimrc](https://github.com/takeedev/intellij-settings/blob/main/ideavim/.ideavimrc) — repo: takeedev/intellij-settings (branch: main)*
