# Marka İzleme Paneli

Trendyol · Hepsiburada · D2C için günlük izleme ve aylık hedef takibi.
Eski panel (`meta-ads-sheets-sync`) olduğu gibi duruyor; bu ayrı bir repo ve ayrı bir adres.

- `veri.py` — Meta (CPAS + D2C), Shopify ve Google Ads betiğinin Sheet sekmesinden gün gün seriler
- `build_panel.py` — serileri `panel_template.html`'e gömüp `index.html` üretir
- `hedef_api.gs` — hedefleri Sheet'in "Hedefler" sekmesine yazan Apps Script web uygulaması
- `sync.py` — eski repodan kopya; yalnız yardımcı fonksiyonları kullanılıyor
- `google_ads_script.js` — Google Ads hesabına kurulan, günlük harcamayı Sheet'e yazan betik

GitHub Actions 2 saatte bir derleyip GitHub Pages'e yayınlar.

Hedef kaydı kurulmadan girilen hedefler yalnız o tarayıcıda (localStorage) saklanır.
Kurulum: `hedef_api.gs` Sheet'e Apps Script olarak eklenir (yazma anahtarsız), web uygulaması olarak dağıtılır, /exec adresi
`HEDEF_API_URL` secret'ına yazılır.
