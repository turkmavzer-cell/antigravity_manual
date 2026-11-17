# antigravity_manual (v1.0.0)

Google Antigravity için **uzun onay kutuları olmadan**, **Argon (Planlama)** ve **Hydrogen (Uygulama / Soru-Cevap)** modelleri arasında hızlı, 2–3 cümlelik akıllı yönlendirme ve çok repolu hafıza eklentisi.

## Çalışma Mantığı

| Gelen İstek | Aktif Model **Hydrogen** (veya Flash) ise | Aktif Model **Argon** (veya Opus) ise |
| :--- | :--- | :--- |
| **Basit Soru / Bilgi / Hydrogen'in İyi Yaptığı İş** | **Hiç sormadan doğrudan yap / cevapla.** | **Dur ve 2 cümleyle uyar:** *"Bu basit bir iş yükü; Argon kotanı korumak için **Hydrogen**'e geçip `devam et` de (veya Argon'da kalmak için `devam et` yaz)."* |
| **Kapsamlı Araştırma / Planlama / Büyük İş** | **Dur ve 2 cümleyle uyar:** *"Bu kapsamlı bir iş; önce planlama yapmak için **Argon**'a geçip `devam et` de."* | **Sormadan kapsamlı planı hazırlayıp bitir; sonunda yaz:** *"✅ Plan tamamlandı. **Hydrogen**'e geçip devam edebilir ya da **Argon**'dan devam edebilirsin."* |

## Kurulum
```powershell
cd $HOME\.gemini\config\plugins
git clone https://github.com/turkmavzer-cell/antigravity_manual.git
```
