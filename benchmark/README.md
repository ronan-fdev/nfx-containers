# Benchmarks

---

## Test Environment

### Hardware Configuration

| Component                | Specification                                                 |
| ------------------------ | ------------------------------------------------------------- |
| **Computer Model**       | Lenovo ThinkPad P15v Gen 3                                    |
| **CPU**                  | 12th Gen Intel Core i7-12800H (20 logical, 14 physical cores) |
| **Base Clock**           | 2.80 GHz                                                      |
| **Turbo Clock**          | 4.80 GHz                                                      |
| **L1 Data Cache**        | 48 KiB (×6 P-cores) + 32 KiB (×8 E-cores)                     |
| **L1 Instruction Cache** | 32 KiB (×6 P-cores) + 64 KiB (×2 E-core clusters)             |
| **L2 Unified Cache**     | 1.25 MiB (×6 P-cores) + 2 MiB (×2 E-core clusters)            |
| **L3 Unified Cache**     | 24 MiB (×1 shared)                                            |
| **RAM**                  | DDR4-3200 (32GB)                                              |
| **GPU**                  | NVIDIA RTX A2000 4GB GDDR6                                    |

### Software Configuration

| Platform    | OS         | Benchmark Framework     | C++ Compiler              | nfx-containers Version | nfx-hashing Version (deps) |
| ----------- | ---------- | ----------------------- | ------------------------- | ---------------------- | -------------------------- |
| **Linux**   | LMDE 7     | Google Benchmark v1.9.4 | GCC 14.2.0-x64            | v0.1.0                 | v0.1.1                     |
| **Linux**   | LMDE 7     | Google Benchmark v1.9.4 | Clang 19.1.7-x64          | v0.1.0                 | v0.1.1                     |
| **Windows** | Windows 10 | Google Benchmark v1.9.4 | MinGW GCC 14.2.0-x64      | v0.1.0                 | v0.1.1                     |
| **Windows** | Windows 10 | Google Benchmark v1.9.4 | Clang-GNU-CLI 19.1.5-x64  | v0.1.0                 | v0.1.1                     |
| **Windows** | Windows 10 | Google Benchmark v1.9.4 | Clang-MSVC-CLI 19.1.5-x64 | v0.1.0                 | v0.1.1                     |
| **Windows** | Windows 10 | Google Benchmark v1.9.4 | MSVC 19.44.35217.0-x64    | v0.1.0                 | v0.1.1                     |

---

# Performance Results

## FastHashMap

| Operation                 | Linux GCC     | Linux Clang    | Windows MinGW GCC | Windows Clang-GNU-CLI | Windows Clang-MSVC-CLI | Windows MSVC  |
| ------------------------- | ------------- | -------------- | ----------------- | --------------------- | ---------------------- | ------------- |
| Construction_1000         | 82,843 ns     | 74,475 ns      | **73,807 ns**     | 89,710 ns             | 81,499 ns              | 89,469 ns     |
| Lookup_1000               | 15,344 ns     | **7,641 ns**   | 12,141 ns         | 15,030 ns             | 14,480 ns              | 19,927 ns     |
| Lookup_10000              | 18,568 ns     | **10,165 ns**  | 13,052 ns         | 13,083 ns             | 13,019 ns              | 20,520 ns     |
| Lookup_100000             | 267,866 ns    | **244,950 ns** | 305,318 ns        | 320,066 ns            | 326,177 ns             | 375,565 ns    |
| HeterogeneousLookup_1000  | 14,751 ns     | **7,768 ns**   | 10,299 ns         | 12,957 ns             | 12,759 ns              | 17,474 ns     |
| Iteration_1000            | **1,280 ns**  | 1,522 ns       | 1,299 ns          | 1,873 ns              | 1,773 ns               | 1,811 ns      |
| IncrementalInsert_1000    | 114,097 ns    | 109,803 ns     | 103,147 ns        | 106,948 ns            | **96,699 ns**          | 119,071 ns    |
| Erase_1000                | 46,469 ns     | 44,665 ns      | 45,830 ns         | **36,178 ns**         | 37,985 ns              | 48,389 ns     |
| MixedOps_1000             | 128,682 ns    | 124,552 ns     | 132,084 ns        | **114,158 ns**        | 116,008 ns             | 143,009 ns    |
| ComplexStruct_1000        | 17,225 ns     | **14,581 ns**  | 17,911 ns         | 15,924 ns             | 16,653 ns              | 20,059 ns     |
| **vs std::unordered_map** |               |                |                   |                       |                        |               |
| Construction_1000         | 62,465 ns     | **61,171 ns**  | 97,549 ns         | 115,556 ns            | 111,755 ns             | 82,324 ns     |
| Lookup_1000               | 10,438 ns     | **9,797 ns**   | 11,295 ns         | 19,616 ns             | 18,051 ns              | 15,891 ns     |
| Lookup_10000              | **12,624 ns** | 13,530 ns      | 13,988 ns         | 15,569 ns             | 15,476 ns              | 16,771 ns     |
| Lookup_100000             | 447,123 ns    | **409,200 ns** | 442,632 ns        | 430,849 ns            | 425,298 ns             | 448,220 ns    |
| HeterogeneousLookup_1000  | 28,853 ns     | **26,799 ns**  | 46,114 ns         | 60,574 ns             | 52,182 ns              | 47,096 ns     |
| Iteration_1000            | 3,209 ns      | 3,321 ns       | **2,604 ns**      | 3,499 ns              | 2,673 ns               | 2,667 ns      |
| IncrementalInsert_1000    | 83,413 ns     | 79,145 ns      | 106,049 ns        | 99,962 ns             | 98,908 ns              | **77,107 ns** |
| Erase_1000                | **35,707 ns** | 37,144 ns      | 46,535 ns         | 55,254 ns             | 51,344 ns              | 50,769 ns     |
| MixedOps_1000             | 93,026 ns     | 92,572 ns      | 115,107 ns        | 101,660 ns            | 103,080 ns             | **88,936 ns** |
| ComplexStruct_1000        | 30,658 ns     | 24,991 ns      | 33,628 ns         | **16,790 ns**         | 17,110 ns              | 26,174 ns     |

## FastHashSet

| Operation                 | Linux GCC      | Linux Clang   | Windows MinGW GCC | Windows Clang-GNU-CLI | Windows Clang-MSVC-CLI | Windows MSVC  |
| ------------------------- | -------------- | ------------- | ----------------- | --------------------- | ---------------------- | ------------- |
| Construction_1000         | 79,505 ns      | 72,677 ns     | 77,231 ns         | **63,994 ns**         | 65,269 ns              | 83,961 ns     |
| Lookup_1000               | 9,785 ns       | **7,431 ns**  | 11,941 ns         | 10,713 ns             | 10,283 ns              | 13,348 ns     |
| Lookup_10000              | 11,738 ns      | **9,452 ns**  | 12,834 ns         | 12,145 ns             | 12,318 ns              | 14,413 ns     |
| Lookup_100000             | **246,401 ns** | 270,363 ns    | 289,506 ns        | 314,054 ns            | 314,720 ns             | 364,375 ns    |
| HeterogeneousLookup_1000  | 15,871 ns      | **7,668 ns**  | 10,372 ns         | 9,556 ns              | 9,518 ns               | 15,823 ns     |
| Iteration_1000            | 1,417 ns       | 1,505 ns      | **1,091 ns**      | 1,524 ns              | 1,514 ns               | 2,144 ns      |
| IncrementalInsert_1000    | 111,486 ns     | 108,437 ns    | 112,840 ns        | **89,078 ns**         | 99,369 ns              | 118,386 ns    |
| Erase_1000                | 47,023 ns      | 46,608 ns     | 45,459 ns         | 38,151 ns             | **37,520 ns**          | 47,020 ns     |
| MixedOps_1000             | 127,241 ns     | 123,225 ns    | 130,783 ns        | **105,984 ns**        | 109,465 ns             | 141,173 ns    |
| ComplexStruct_1000        | 16,240 ns      | **14,353 ns** | 17,635 ns         | 15,938 ns             | 16,480 ns              | 19,148 ns     |
| **vs std::unordered_set** |                |               |                   |                       |                        |               |
| Construction_1000         | 63,750 ns      | **59,695 ns** | 103,279 ns        | 85,581 ns             | 83,717 ns              | 85,636 ns     |
| Lookup_1000               | 10,367 ns      | **9,581 ns**  | 11,353 ns         | 13,934 ns             | 13,927 ns              | 22,942 ns     |
| Lookup_10000              | 13,016 ns      | **12,305 ns** | 14,319 ns         | 15,514 ns             | 15,989 ns              | 21,484 ns     |
| Lookup_100000             | **400,884 ns** | 462,599 ns    | 442,483 ns        | 442,666 ns            | 421,160 ns             | 415,355 ns    |
| HeterogeneousLookup_1000  | 28,482 ns      | **27,452 ns** | 48,619 ns         | 49,858 ns             | 46,521 ns              | 50,962 ns     |
| Iteration_1000            | 3,339 ns       | 3,401 ns      | 2,914 ns          | 2,649 ns              | **1,896 ns**           | 2,618 ns      |
| IncrementalInsert_1000    | 81,966 ns      | 78,657 ns     | 114,526 ns        | 92,469 ns             | 92,461 ns              | **77,492 ns** |
| Erase_1000                | 36,580 ns      | **35,448 ns** | 48,329 ns         | 50,404 ns             | 49,583 ns              | 48,438 ns     |
| MixedOps_1000             | 93,921 ns      | 91,754 ns     | 123,154 ns        | 100,154 ns            | 101,762 ns             | **89,988 ns** |
| ComplexStruct_1000        | 31,776 ns      | 25,720 ns     | 30,277 ns         | **17,260 ns**         | 17,196 ns              | 28,572 ns     |

## PerfectHashMap

| Operation                 | Linux GCC    | Linux Clang   | Windows MinGW GCC | Windows Clang-GNU-CLI | Windows Clang-MSVC-CLI | Windows MSVC |
| ------------------------- | ------------ | ------------- | ----------------- | --------------------- | ---------------------- | ------------ |
| Construction_100          | 13,510 ns    | 12,741 ns     | 13,410 ns         | **11,911 ns**         | 19,933 ns              | 25,268 ns    |
| Construction_1000         | 199,327 ns   | 200,572 ns    | 194,514 ns        | **184,513 ns**        | 248,429 ns             | 296,630 ns   |
| Lookup_100                | 892 ns       | **727 ns**    | 748 ns            | 843 ns                | 914 ns                 | 1,503 ns     |
| Lookup_1000               | 10,815 ns    | **7,961 ns**  | 11,598 ns         | 9,963 ns              | 10,435 ns              | 18,122 ns    |
| Lookup_10000              | 12,920 ns    | **9,916 ns**  | 13,568 ns         | 13,093 ns             | 12,692 ns              | 20,912 ns    |
| HeterogeneousLookup_1000  | 10,988 ns    | **8,145 ns**  | 11,825 ns         | 9,870 ns              | 10,868 ns              | 14,912 ns    |
| FailedLookup_100          | 914 ns       | **737 ns**    | 770 ns            | 912 ns                | 994 ns                 | 1,453 ns     |
| Iteration_1000            | 2,064 ns     | 1,704 ns      | 1,922 ns          | **1,491 ns**          | 1,684 ns               | 2,869 ns     |
| IntKeys_1000              | 1,536 ns     | 1,504 ns      | 1,629 ns          | **1,476 ns**          | 1,543 ns               | 5,865 ns     |
| ComplexStruct_1000        | 16,901 ns    | **15,166 ns** | 17,554 ns         | 15,924 ns             | 16,804 ns              | 25,955 ns    |
| HotPath_100               | 89,710 ns    | **72,211 ns** | 94,123 ns         | 90,347 ns             | 96,176 ns              | 146,124 ns   |
| **vs std::unordered_map** |              |               |                   |                       |                        |              |
| Construction_100          | **3,878 ns** | 3,842 ns      | 4,142 ns          | 4,017 ns              | 8,281 ns               | 9,442 ns     |
| Construction_1000         | 63,382 ns    | **62,625 ns** | 66,027 ns         | 115,490 ns            | 96,778 ns              | 110,042 ns   |
| Lookup_100                | 918 ns       | **851 ns**    | 906 ns            | 1,023 ns              | 1,188 ns               | 1,645 ns     |
| Lookup_1000               | 10,358 ns    | **9,965 ns**  | 11,238 ns         | 13,921 ns             | 13,564 ns              | 19,496 ns    |
| Lookup_10000              | 12,703 ns    | **12,470 ns** | 14,126 ns         | 15,931 ns             | 15,947 ns              | 20,508 ns    |
| HeterogeneousLookup_1000  | 28,645 ns    | **27,538 ns** | 42,929 ns         | 49,895 ns             | 45,737 ns              | 51,562 ns    |
| FailedLookup_100          | 918 ns       | **871 ns**    | 929 ns            | 1,038 ns              | 1,274 ns               | 1,692 ns     |
| Iteration_1000            | 3,270 ns     | 3,398 ns      | 3,689 ns          | **2,644 ns**          | 2,821 ns               | 2,903 ns     |
| IntKeys_1000              | 2,157 ns     | **1,370 ns**  | 1,524 ns          | 1,450 ns              | 1,660 ns               | 1,792 ns     |
| ComplexStruct_1000        | 30,144 ns    | 26,290 ns     | 31,395 ns         | **17,203 ns**         | 17,384 ns              | 26,174 ns    |
| HotPath_100               | 93,239 ns    | **86,910 ns** | 92,902 ns         | 87,074 ns             | 125,872 ns             | 153,326 ns   |

## TransparentHashMap

| Operation                 | Linux GCC  | Linux Clang   | Windows MinGW GCC | Windows Clang-GNU-CLI | Windows Clang-MSVC-CLI | Windows MSVC  |
| ------------------------- | ---------- | ------------- | ----------------- | --------------------- | ---------------------- | ------------- |
| Construction_1000         | 79,387 ns  | **75,287 ns** | 116,083 ns        | 94,072 ns             | 96,558 ns              | 102,603 ns    |
| Lookup_1000               | 24,283 ns  | 13,523 ns     | 26,526 ns         | 9,963 ns              | **9,952 ns**           | 20,663 ns     |
| Lookup_10000              | 29,587 ns  | 17,397 ns     | 25,768 ns         | 13,093 ns             | **12,018 ns**          | 18,060 ns     |
| HeterogeneousLookup_1000  | 25,358 ns  | 13,745 ns     | 23,645 ns         | **9,870 ns**          | 9,954 ns               | 25,818 ns     |
| Iteration_1000            | 3,232 ns   | 3,395 ns      | 2,576 ns          | **1,491 ns**          | 2,515 ns               | 2,714 ns      |
| IncrementalInsert_1000    | 113,299 ns | 110,489 ns    | 141,177 ns        | 110,056 ns            | **105,174 ns**         | 117,661 ns    |
| Erase_1000                | 60,238 ns  | 60,810 ns     | 70,371 ns         | **41,699 ns**         | 48,518 ns              | 51,915 ns     |
| MixedOps_1000             | 131,694 ns | 126,485 ns    | 157,009 ns        | 126,075 ns            | **112,384 ns**         | 132,500 ns    |
| ComplexStruct_1000        | 32,276 ns  | 26,300 ns     | 32,800 ns         | **15,924 ns**         | 18,059 ns              | 26,427 ns     |
| **vs std::unordered_map** |            |               |                   |                       |                        |               |
| Construction_1000         | 64,453 ns  | **63,480 ns** | 101,426 ns        | 115,490 ns            | 97,803 ns              | 104,426 ns    |
| Lookup_1000               | 10,339 ns  | 10,044 ns     | 11,193 ns         | 13,921 ns             | 13,814 ns              | **9,147 ns**  |
| Lookup_10000              | 13,592 ns  | 12,623 ns     | 14,057 ns         | 15,931 ns             | 16,836 ns              | **11,355 ns** |
| HeterogeneousLookup_1000  | 28,084 ns  | 27,790 ns     | 48,592 ns         | 49,895 ns             | 44,794 ns              | **25,079 ns** |
| Iteration_1000            | 3,276 ns   | 3,387 ns      | **2,762 ns**      | 2,644 ns              | 2,551 ns               | 2,765 ns      |
| IncrementalInsert_1000    | 83,333 ns  | 84,361 ns     | 106,605 ns        | 112,842 ns            | 110,810 ns             | **76,973 ns** |
| Erase_1000                | 36,469 ns  | 40,134 ns     | 47,047 ns         | 52,390 ns             | 52,671 ns              | **34,725 ns** |
| MixedOps_1000             | 95,867 ns  | 98,759 ns     | 115,974 ns        | 126,142 ns            | 121,562 ns             | **87,828 ns** |
| ComplexStruct_1000        | 32,427 ns  | 25,543 ns     | 33,199 ns         | **17,203 ns**         | 18,350 ns              | 26,471 ns     |

## TransparentHashSet

| Operation                 | Linux GCC     | Linux Clang   | Windows MinGW GCC | Windows Clang-GNU-CLI | Windows Clang-MSVC-CLI | Windows MSVC  |
| ------------------------- | ------------- | ------------- | ----------------- | --------------------- | ---------------------- | ------------- |
| Construction_1000         | 77,263 ns     | **75,111 ns** | 103,204 ns        | 90,229 ns             | 92,064 ns              | 95,322 ns     |
| Lookup_1000               | 17,085 ns     | 13,422 ns     | 24,216 ns         | **10,087 ns**         | 10,119 ns              | 17,771 ns     |
| Lookup_10000              | 22,663 ns     | 16,550 ns     | 27,210 ns         | 12,972 ns             | **11,576 ns**          | 15,408 ns     |
| HeterogeneousLookup_1000  | 18,436 ns     | 13,686 ns     | 27,055 ns         | **9,902 ns**          | 9,981 ns               | 20,861 ns     |
| Iteration_1000            | 3,073 ns      | 3,098 ns      | **2,097 ns**      | 1,524 ns              | 3,052 ns               | 3,339 ns      |
| IncrementalInsert_1000    | 114,502 ns    | 112,208 ns    | 129,781 ns        | 108,873 ns            | **101,030 ns**         | 109,165 ns    |
| Erase_1000                | 59,580 ns     | 60,942 ns     | 70,415 ns         | 56,371 ns             | **47,266 ns**          | 49,768 ns     |
| MixedOps_1000             | 146,708 ns    | 145,190 ns    | 161,476 ns        | 127,758 ns            | **112,776 ns**         | 127,965 ns    |
| ComplexStruct_1000        | 30,484 ns     | 31,407 ns     | 42,270 ns         | **15,831 ns**         | 21,080 ns              | 30,918 ns     |
| **vs std::unordered_set** |               |               |                   |                       |                        |               |
| Construction_1000         | **56,946 ns** | 60,223 ns     | 104,559 ns        | 85,581 ns             | 92,447 ns              | 99,489 ns     |
| Lookup_1000               | 10,161 ns     | **10,003 ns** | 11,382 ns         | 13,934 ns             | 13,720 ns              | 14,883 ns     |
| Lookup_10000              | 12,537 ns     | 12,839 ns     | 13,704 ns         | 15,514 ns             | 15,480 ns              | **11,634 ns** |
| HeterogeneousLookup_1000  | 18,735 ns     | 13,765 ns     | 27,156 ns         | 49,858 ns             | **9,786 ns**           | 20,903 ns     |
| Iteration_1000            | 3,331 ns      | 3,366 ns      | 3,032 ns          | 2,649 ns              | 3,087 ns               | **3,310 ns**  |
| IncrementalInsert_1000    | 79,361 ns     | 82,884 ns     | 110,893 ns        | 92,469 ns             | 103,453 ns             | **77,795 ns** |
| Erase_1000                | 35,606 ns     | 38,781 ns     | 49,536 ns         | 50,404 ns             | 51,265 ns              | **34,433 ns** |
| MixedOps_1000             | 98,311 ns     | 100,512 ns    | 125,398 ns        | 100,154 ns            | 118,270 ns             | **90,807 ns** |
| ComplexStruct_1000        | 31,960 ns     | 31,327 ns     | 38,300 ns         | **17,260 ns**         | 21,661 ns              | 30,297 ns     |

---

_Benchmarks executed on November 15, 2025_
