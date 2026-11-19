# Bağlı Projeler Kayıt Defteri (`REGISTRY.md`)

`antigravity_manual` çok repolu çalışma sistemine bağlanan projelerin listesidir. Yeni bir projeyi bağlamak için ilgili proje açıkken **"projeyi bağla"** (`project-link` skill'i) demeniz yeterlidir.

## Commit Politikası Seçenekleri
- **`sor` (Varsayılan):** Projeye özel öğrenimler `.agents/learnings/PROJECT.md` dosyasına yazılır; proje reposunda commit/push yapmadan önce kullanıcıya sorulur.
- **`ayri-otomatik`:** Öğrenimler kod değişiklikleriyle karıştırılmadan ayrı bir `docs(learnings): ...` commit'i olarak otomatik commit/push edilir.
- **`kodla-birlikte`:** Öğrenimler ayrı commit yapılmaz, mevcut görev/kod commit'ine dahil edilir.
- **`otomatik-hafiza`:** Yalnızca hafıza/öğrenim dosyaları otomatik işlenir; kod ve kural değişiklikleri için kullanıcıya sorulur (`sor`).
- **`kullanici-github-desktop`:** Yerel dosyalar güncellenir; GitHub commit/push işlemini kullanıcı kendi GitHub Desktop arayüzünden yapar (`sor`).

## Kayıtlı Projeler

| Proje Adı | Yerel Yol | GitHub Repo URL | Teknoloji Yığını | Bağlanma Tarihi | Commit Politikası |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `antigravity_manual` (Core) | `C:\Users\dell\.gemini\config\plugins\antigravity_manual` | https://github.com/turkmavzer-cell/antigravity_manual | PowerShell, Markdown, Antigravity Plugin/Hooks | 2026-11-17 | `ayri-otomatik` (Hook ile anında) |
