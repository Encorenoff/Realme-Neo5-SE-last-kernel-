# OnePlus Ace 2 (OxygenOS 16) ядро 5.10.236 → 5.10.246

База: `OnePlusOSS/android_kernel_common_oneplus_sm8475`, ветка `oneplus/sm8475_b_16.0.0_ace_2`
(релиз PHK110_16.0.3.501, 5.10.236).

## Что сделано
Один патч `patches/oneplus-ace2-5.10.236-to-5.10.246.patch` (1879 файлов):
- ACK `android12-5.10`: `ASB-2025-05-05` (.236) → ветка `android12-5.10` (.245);
- апстримный stable v5.10.245 → v5.10.246.

Патч проверен `git apply --check` на чистом клоне ветки — **ложится без конфликтов**.

## Использование
```bash
./scripts/apply.sh            # клон + патч, ветка neo5se-5.10.246, SUBLEVEL = 246
```
Дальше пушьте `oneplus_kernel` в свой GitHub-репозиторий.

## Что НЕ перенесено (в `skipped/`, не критично)
Эти 4 hunk'а не подошли, потому что код в дереве OnePlus устроен иначе:
- `drivers/base/regmap/regmap.c` — косметическая проверка `config`;
- `fs/nfsd/nfs4proc.c` — размер в `strscpy`;
- `fs/f2fs/file.c` — правка `reserve_compress_blocks` (f2fs compress);
- `net/vmw_vsock/af_vsock.c` — в дереве другая структура `vsock_assign_transport`.
Остальные «конфликты» оказались уже применёнными в дереве OnePlus или легли с fuzz.

## Важно
- **Сборка не проверялась** (в окружении нет тулчейна и остальных репозиториев).
- Это только *common*-ядро. Для сборки нужны ещё `android_kernel_modules_and_devicetree_oneplus_sm8475`
  (ветка `oneplus/sm8475_b_16.0.0_ace_2`) и kernel_platform-манифест.
- **Проверьте SoC своего телефона.** Ace 2 = SM8475 (платформа waipio). В исходниках Realme для
  GT Neo5 SE лежат конфиги `neo_la` / `neo_le`, то есть платформа, похоже, другая (Snapdragon 7+ Gen 2).
  Тогда драйверы, devicetree и defconfig именно под Neo5 SE из дерева OnePlus Ace 2 не возьмутся —
  их придётся переносить из дерева Realme.
