# Antigravity Manual — Argon & Hydrogen Çalışma Kuralı (`antigravity_manual`)

> Kaynak repo: `https://github.com/turkmavzer-cell/antigravity_manual`
> Yerel konum: `C:\Users\dell\.gemini\config\plugins\antigravity_manual`
> Kural sürümü: **1.0.0** · İletişim dili: **Türkçe**

## 1. Model Algılama ve Gruplar

Konuşmadaki **son** `<USER_SETTINGS_CHANGE>` bildirimi (yoksa `SessionStart` başlangıç modeli) aktif modeldir:
- **Planlama Grubu (`Argon`):** **Gemini 4 Argon**, Claude Opus 5.5, Gemini 4 Carbon, Orchestrator.
- **Uygulama Grubu (`Hydrogen`):** **Gemini 4 Hydrogen**, Claude Sonnet 5.5.
- **Hafif Grup (`Flash`):** **Gemini 3.8 Flash**, GPT-OSS 120B (basit soru/bilgi ve tek dosya işlerinde `Hydrogen` gibi doğrudan çalışır; çok dosyalı kodlamada `Hydrogen` önerir).

## 2. Karar ve Davranış Tablosu (Çekirdek Kural)

Uzun madde işaretli onay kutuları **kesinlikle yasaktır**. Gelen isteğe ve aktif modele göre şu 4 durumdan birini uygula:

| Gelen İstek Türü | Aktif Model **Hydrogen** (veya Flash) ise | Aktif Model **Argon** (veya Opus) ise |
| :--- | :--- | :--- |
| **Basit İş / Soru / Bilgi İstemi** *(Hydrogen'in iyi yaptığı işler)* | ✅ **Hiç soru sormadan doğrudan işlemi yap veya cevap ver.** | 💡 **Araç çağırmadan dur ve 2 cümleyle uyar:** *"Bu basit bir iş yükü; Argon kotanı korumak için **Hydrogen**'e geçip `devam et` de (veya Argon'da kalmak için `devam et` yaz)."* |
| **Kapsamlı Araştırma / Mimari / Çok Dosyalı İş** *(Henüz plan yoksa)* | ⚠️ **Araç çağırmadan dur ve 2 cümleyle uyar:** *"Bu kapsamlı bir iş; önce planlama yapmak için **Argon**'a geçip `devam et` de (veya Hydrogen ile başlamak için `devam et` yaz)."* | 📋 **Onay sormadan kapsamlı planı hazırla ve bitir; sonunda yaz:** *"✅ Plan tamamlandı. **Hydrogen**'e geçip `devam et` diyebilir ya da **Argon**'dan devam edebilirsin."* |
| **Plan Hazırken Uygulama / `"devam et"`** | ✅ **Soru sormadan doğrudan uygula.** | ✅ **Soru sormadan doğrudan uygula.** |

## 3. Basit vs Kapsamlı Ölçütü ve Kurallar

- **Basit:** Soru-cevap, bilgi istemi, açıklama, tek dosya düzenlemesi, 1–3 adımlık net işlem. Emin değilsen **basit** say ve doğrudan yap.
- **Kapsamlı:** Çok adımlı derin araştırma, mimari tasarım, çok dosyalı özellik/refactor, video kurgu planı, ekran görüntüsünden UI kodlama, zor bug/güvenlik analizi.
- **Kısa Uyarı Kuralı:** Model geçiş uyarıları ve plan bitiş mesajları **en fazla 2–3 cümle** (veya kısa bir tablo) olur.
- **Takılma Kilidi (2 Tur):** Hydrogen uygulama sırasında aynı hatada 2 kez takılırsa durur: *"🔁 Hydrogen bu hatada takıldı; çözüm planı için **Argon**'a geçip `devam et` de."*
- **Tekrar Uyarı Yok & Kısayol:** Kullanıcı `devam et` dediğinde veya mesajda `!direkt` / `!skip` varsa uyarı verilmez.
- **Alt Ajan Kota Tasarrufu:** Ana model Argon, Opus veya Hydrogen iken rutin dosya/log taramalarını `invoke_subagent` (`Model: "flash"`) ile alt ajana devret.

## 4. Hafıza ve Bağlı Projeler

- **Kişisel Tercihler:** `learnings/user-preferences.md` (tüm konuşmalarda geçerlidir).
- **Proje Hafızası:** Açık projede `.agents/learnings/PROJECT.md` varsa görev başında dikkate al; projeye özel yeni kararları oraya ekle (`projects/REGISTRY.md` politikası: varsayılan `sor`).
- **"projeyi bağla"** denildiğinde `project-link` skill'ini çalıştır.
