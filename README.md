# Swift로 배우는 자료구조

> 컴공과 필수 자료구조 10개를 Swift로 직접 구현하고, 인터랙티브 시각화로 확인합니다.
> 개발자리(Leeo) 교육 콘텐츠

[![GitHub Pages](https://img.shields.io/badge/GitHub%20Pages-Live-brightgreen)](https://m1zz.github.io/swift-data-structures/)

---

## 📦 리소스

| 파일 | 설명 |
|------|------|
| [`index.html`](./index.html) | 인터랙티브 시각화 (GitHub Pages) |
| [`DataStructures.playgroundbook/`](./DataStructures.playgroundbook/) | Swift Playgrounds 실습 북 |
| [`Swift_자료구조_교안.docx`](./Swift_자료구조_교안.docx) | 학습 교안 |

## 🗂 챕터 구성

| Ch | 주제 | 핵심 개념 |
|----|------|----------|
| 01 | Array vs ContiguousArray | CoW, 메모리 레이아웃 |
| 02 | Linked List | 노드 구조, O(1) 삽입/삭제 |
| 03 | Stack / Queue | LIFO/FIFO, 프로토콜 추상화 |
| 04 | Deque | 링 버퍼, 양방향 O(1) |
| 05 | Binary Tree | 전위/중위/후위/레벨 순회 |
| 06 | Binary Search Tree | 삽입/삭제(3케이스)/탐색 |
| 07 | Heap / Priority Queue | siftUp/siftDown, iOS RunLoop 연결 |
| 08 | Graph | 인접행렬 vs 인접리스트, BFS/DFS |
| 09 | Hash Table | 충돌 해결, Swift Dictionary 내부 |
| 10 | Trie | 자동완성 DFS, O(m) 탐색 |

## 🚀 사용법

### 인터랙티브 시각화
→ **[https://m1zz.github.io/swift-data-structures/](https://m1zz.github.io/swift-data-structures/)** 에서 바로 확인

또는 로컬에서:
```bash
open index.html
```

### Swift Playground Book
1. `DataStructures.playgroundbook` 폴더를 iPad/Mac으로 전송
2. Swift Playgrounds 앱으로 열기
3. 각 챕터별 코드 실행 및 수정

### 로컬 개발
```bash
git clone https://github.com/m1zz/swift-data-structures.git
cd swift-data-structures
open index.html
```

## 📖 권장 학습 순서

```
교안(개념) → index.html(시각화) → Playground(코딩) → 교안(복습)
```

---

**개발자리** | [YouTube](https://youtube.com/@개발자리) | Apple Developer Academy @ POSTECH
