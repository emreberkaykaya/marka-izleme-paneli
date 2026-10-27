#!/usr/bin/env bash
# Marka izleme panelini ilk kez yayına alır: GitHub reposu, secret'lar, Pages,
# ilk derleme. Bir kez çalıştırılır; sonrası GitHub Actions'ta 2 saatte bir.
# Secret değerleri ekrana basılmaz: .env ve service-account.json'dan okunur.
set -euo pipefail
cd "$(dirname "$0")"

REPO="emreberkaykaya/marka-izleme-paneli"

gh repo create "$REPO" --public --source . --push \
  -d "Trendyol · Hepsiburada · D2C izleme ve hedef paneli"

set -a; . ./.env; set +a
for v in META_ACCESS_TOKEN META_ACCESS_TOKEN_AQUA_DI_POLO META_ACCESS_TOKEN_FRIME \
         META_ACCESS_TOKEN_PIERRE_CARDIN SHOPIFY_ACCESS_TOKEN_FRIME SHOPIFY_SHOP_FRIME \
         SHOPIFY_ACCESS_TOKEN_AQUA_DI_POLO SHOPIFY_SHOP_AQUA_DI_POLO SHOPIFY_SHOP_MISSLIVA \
         GOOGLE_SHEET_ID; do
  printf '%s' "${!v}" | gh secret set "$v" -R "$REPO" >/dev/null
  echo "secret: $v"
done
gh secret set GOOGLE_SERVICE_ACCOUNT_JSON -R "$REPO" < service-account.json >/dev/null
echo "secret: GOOGLE_SERVICE_ACCOUNT_JSON"

gh api -X POST "repos/$REPO/pages" -f build_type=workflow >/dev/null
echo "Pages açıldı"

gh workflow run panel.yml -R "$REPO"
echo "İlk derleme başladı: https://github.com/$REPO/actions"
echo "Panel birkaç dakika içinde: https://emreberkaykaya.github.io/marka-izleme-paneli/"
