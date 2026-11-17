# Değişiklik Günlüğü (`CHANGELOG.md`)

## 1.0.0 - 2026-11-17
- **Yeni `antigravity_manual` Mimarisi:** Eski uzun 5 maddelik model öneri kutuları kaldırıldı; yalnızca Argon (planlama) ve Hydrogen (uygulama/soru-cevap) arasındaki 4 durumlu tablo ve en fazla 2–3 cümlelik uyarı kuralı getirildi.
- **Basit İşte Sıfır Kesinti:** Hydrogen seçiliyken basit soru, bilgi istemi ve günlük işlerde onay beklemeden doğrudan yanıt/işlem yapma kuralı eklendi.
- **Argon'da Doğrudan Planlama:** Argon seçiliyken kapsamlı işlerde ön onay sormadan doğrudan planı hazırlayıp bitirme ve sonunda Hydrogen/Argon devam seçeneği sunma akışı eklendi.
- **UTF-8 BOM ve Hedefli Git Senkronizasyonu:** PowerShell 5.1 Türkçe karakter bozulmasını önleyen BOM'lu betikler ve yalnız değişen hafıza dosyalarını commit'leyen `sync.ps1` eklendi.
