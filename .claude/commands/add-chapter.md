# 새 챕터 추가 — 코멘트(utterances) + 후원 섹션 포함

새 챕터를 `docs/index.html`에 추가합니다. 사이드바, 홈 목록, 챕터 HTML(GitHub Issues 코멘트 + 카카오페이 후원), JS 초기화까지 자동으로 처리합니다.

## 사용법

```
/add-chapter
```

실행하면 다음 정보를 물어봅니다:
- 챕터 번호 (예: 11)
- 챕터 제목 (예: AVL Tree)
- 챕터 부제목 (한 줄 설명)

## 이 명령이 하는 일

아래 절차를 순서대로 수행합니다:

### 1. 사이드바에 항목 추가
기존 마지막 `sidebar-item` 뒤에 추가합니다. `showChapter(N)` 인덱스는 home=0 기준으로 순서대로 증가합니다.

```html
<div class="sidebar-item" onclick="showChapter(N)"><span class="ch-num">{CHNUM}</span> {TITLE}</div>
```

### 2. 홈 페이지 챕터 목록에 추가
`.chapter-list` 안 마지막 항목 뒤에 추가합니다.

```html
<div class="chapter-list-item" onclick="showChapter(N)">
  <div class="chapter-list-num">{CHNUM}</div>
  <div><div class="chapter-list-name">{TITLE}</div><div class="chapter-list-key">{SUBTITLE}</div></div>
</div>
```

### 3. `</main>` 바로 앞에 챕터 HTML 블록 삽입

`CHNUM` = 두 자리 숫자 (11, 12...), `CHID` = `ch-10` 형식, `COMMENT_ID` = `ch10` 형식, `LABEL` = utterances issue 제목 (예: `Ch11 · AVL Tree`)

```html
<!-- ===================== CH{CHNUM}: {TITLE} ===================== -->
<div class="chapter" id="{CHID}">
  <div class="chapter-header">
    <div class="chapter-tag">Chapter {CHNUM}</div>
    <h1 class="chapter-title">{TITLE}</h1>
    <p class="chapter-subtitle">{SUBTITLE}</p>
  </div>

  <div class="info-row">
    <div class="info-box">
      <div class="info-box-label concept">개념</div>
      <p><!-- 개념 설명 --></p>
    </div>
    <div class="info-box">
      <div class="info-box-label guide">사용법</div>
      <ol>
        <li><!-- 사용법 --></li>
      </ol>
    </div>
  </div>

  <div class="viz-card">
    <div class="viz-label"><!-- 시각화 제목 --></div>
    <div class="controls">
      <!-- 버튼들 -->
    </div>
    <svg class="diagram" id="{CHID}-svg" height="300"></svg>
    <div class="status-bar" id="{CHID}-status">준비</div>
  </div>

  <div class="chapter-footer">
    <div class="chapter-footer-grid">
      <div class="comments-section">
        <div class="section-heading">코멘트</div>
        <div class="utterances-wrap" id="utterances-{COMMENT_ID}"></div>
      </div>
      <div class="donation-section">
        <div class="section-heading" style="text-align:left;">후원하기</div>
        <div class="donation-desc">콘텐츠가 도움이 됐다면<br>커피 한 잔의 후원을 부탁드려요 :)</div>
        <img class="donation-qr" src="kakao-pay-qr.jpg" alt="카카오페이 QR">
        <div class="donation-name">이현호</div>
        <div class="donation-kakao-badge">카카오페이</div>
      </div>
    </div>
  </div>
</div>
```

### 4. `CH_LABELS` 객체에 새 항목 추가
`CH_LABELS` 객체에 아래 한 줄 추가합니다 (GitHub Issues 제목으로 사용됩니다):

```js
{COMMENT_ID}: 'Ch{CHNUM} · {TITLE}',
```

### 5. `CHID_BY_INDEX` 배열 끝에 ID 추가
```js
const CHID_BY_INDEX = [null,'ch0',..., '{COMMENT_ID}'];
```

### 6. `window.addEventListener('load', ...)` / `resize` 에 draw 함수 추가 (있다면)

## 체크리스트

- [ ] 사이드바 항목 추가 (`showChapter(N)`)
- [ ] 홈 챕터 목록 항목 추가
- [ ] 챕터 HTML 블록 삽입 (`utterances-{COMMENT_ID}` + 후원 섹션 포함)
- [ ] `CH_LABELS`에 utterances 이슈 제목 추가
- [ ] `CHID_BY_INDEX` 배열 업데이트
- [ ] load / resize 리스너에 draw 함수 추가 (있다면)

## 코멘트 시스템 동작 방식

- utterances (https://utteranc.es) — GitHub Issues 기반
- 챕터별 `CH_LABELS` 값이 Issue 제목이 됨
- 챕터를 처음 열 때 lazy load, 이후 캐싱 (`utterancesLoaded` Set)
- 댓글 작성에 GitHub 계정 필요
- utterances GitHub App이 `m1zz/swift-data-structures` 레포에 설치되어 있어야 함
  → https://github.com/apps/utterances 에서 설치
