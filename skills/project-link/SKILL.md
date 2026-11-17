---
name: project-link
description: Açık olan proje workspace'ini antigravity_manual çok repolu çalışma sistemine bağlar. Kullanıcı "projeyi bağla", "bu projeyi sisteme ekle", "proje hafızasını kur" dediğinde kullanılır.
---

# Proje Bağlama Prosedürü (`project-link`)

Core repo kökü: `C:\Users\dell\.gemini\config\plugins\antigravity_manual`
Şablon dizini: `C:\Users\dell\.gemini\config\plugins\antigravity_manual\templates\project`
Kayıt defteri: `C:\Users\dell\.gemini\config\plugins\antigravity_manual\projects\REGISTRY.md`

## Adım 1: Açık Workspace'i ve Teknoloji Yığınını Tespit Et
1. Açık olan proje dizinini belirle (aktif workspace yoksa kullanıcıya hangi klasörü bağlamak istediğini sor).
2. Proje kökündeki yapılandırma dosyalarını hızlıca tara (`package.json`, `pyproject.toml`, `requirements.txt`, `README.md`, `git remote -v`).

## Adım 2: Proje Şablonunu Kur (`AGENTS.md` ve `.agents/learnings/PROJECT.md`)
1. `templates/project/AGENTS.md` şablonunu kullanarak `<proje>/AGENTS.md` dosyasını oluştur (varsa üzerine yazma, sonuna *"Proje Öğrenim ve Hafıza Kuralı"* bölümünü ekle).
2. `templates/project/.agents/learnings/PROJECT.md` şablonunu kullanarak `<proje>/.agents/learnings/PROJECT.md` dosyasını oluştur.
3. `<proje>/.agents/skills/` klasörünün mevcut olduğundan emin ol (gerekirse `.gitkeep` koy).

## Adım 3: Kayıt Defterine (`projects/REGISTRY.md`) Ekle
1. `C:\Users\dell\.gemini\config\plugins\antigravity_manual\projects\REGISTRY.md` tablosuna projeyi ekle (varsayılan commit politikası: `sor`).
2. `PostToolUse` hook'u otomatik olarak core repoyu GitHub ile senkronize eder.

## Adım 4: Proje Reposunda Commit Onayı (`sor` Politikası)
- Proje reposunda oluşturulan `AGENTS.md` ve `.agents/learnings/PROJECT.md` dosyalarını kullanıcıdan onay almadan commit/push yapma.
