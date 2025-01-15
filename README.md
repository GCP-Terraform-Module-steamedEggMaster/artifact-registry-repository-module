# artifact-registry-repository-module
GCP Terraform Artifact Registry Repository Module Repo

GCP에서 **Artifact Registry**를 생성하고 관리하기 위한 Terraform 모듈입니다.  <br>
이 모듈은 다양한 저장소 포맷(Docker, Maven, Python 등)에 대해 유연하고 쉽게 구성할 수 있도록 설계되었습니다.

<br>

## 📑 **목차**
1. [모듈 특징](#모듈-특징)
2. [사용 방법](#사용-방법)
    1. [사전 준비](#1-사전-준비)
    2. [입력 변수](#2-입력-변수)
    3. [모듈 호출 예시](#3-모듈-호출-예시)
    4. [출력값 (Outputs)](#4-출력값-outputs)
    5. [지원 버전](#5-지원-버전)
    6. [모듈 개발 및 관리](#6-모듈-개발-및-관리)
3. [테스트](#terratest를-이용한-테스트)
4. [주요 버전 관리](#주요-버전-관리)
5. [기여](#기여-contributing)
6. [라이선스](#라이선스-license)

---

## 모듈 특징

- 다양한 포맷(Docker, Maven, Python 등)에 대한 Artifact Registry 저장소 생성 지원.
- 사용자 정의 레이블 및 설명 설정 가능.
- 고객 관리 암호화 키(KMS)를 통한 보안 지원.
- Docker 태그 수정 방지 및 Maven 버전 정책 지원.
- 취약점 스캔 설정 제공.
- 생성된 저장소의 주요 속성 출력.

---

## 사용 방법

### 1. 사전 준비

다음 사항을 확인하세요:
1. Google Cloud 프로젝트 준비.
2. 적절한 IAM 권한 필요: `roles/artifactregistry.admin`

<br>

### 2. 입력 변수

| 변수명                     | 타입           | 필수 여부 | 기본값        | 설명                                       |
|----------------------------|----------------|-----------|---------------|--------------------------------------------|
| `repository_id`            | string         | ✅        | 없음          | Artifact Registry 저장소의 ID               |
| `format`                   | string         | ✅        | 없음          | 저장소 포맷 (예: `DOCKER`, `MAVEN`, `PYTHON`)|
| `description`              | string         | ❌        | `null`        | 저장소 설명                                 |
| `labels`                   | map(string)    | ❌        | `{}`          | 사용자 정의 메타데이터 레이블               |
| `kms_key_name`             | string         | ❌        | `null`        | 고객 관리 암호화 키                        |
| `location`                 | string         | ❌        | `null`        | 저장소 위치                                 |
| `project`                  | string         | ❌        | `null`        | 저장소가 속한 GCP 프로젝트 ID               |
| `docker_config`            | object         | ❌        | `null`        | Docker 저장소 설정                         |
| `maven_config`             | object         | ❌        | `null`        | Maven 저장소 설정                          |
| `vulnerability_scanning_config` | object    | ❌        | `null`        | 취약점 스캔 설정                           |
| `timeout_create`           | string         | ❌        | `"20m"`       | 생성 타임아웃                               |
| `timeout_update`           | string         | ❌        | `"20m"`       | 업데이트 타임아웃                           |
| `timeout_delete`           | string         | ❌        | `"20m"`       | 삭제 타임아웃                               |

#### `docker_config` 객체 필드
| 필드명            | 타입  | 필수 여부 | 설명                                |
|-------------------|-------|-----------|-------------------------------------|
| `immutable_tags`  | bool  | ❌        | 태그 수정 방지 여부 (기본값: `false`) |

#### `maven_config` 객체 필드
| 필드명                     | 타입   | 필수 여부 | 설명                                |
|----------------------------|--------|-----------|-------------------------------------|
| `allow_snapshot_overwrites`| bool   | ❌        | Snapshot 덮어쓰기 허용 여부         |
| `version_policy`           | string | ❌        | Maven 버전 정책 (기본값: `VERSION_POLICY_UNSPECIFIED`) |

#### `vulnerability_scanning_config` 객체 필드
| 필드명             | 타입   | 필수 여부 | 설명                                |
|--------------------|--------|-----------|-------------------------------------|
| `enablement_config`| string | ❌        | 스캔 활성화 설정 (`INHERITED`(기본값), `DISABLED`, `""`) |

<br>

### 3. 모듈 호출 예시

```hcl
module "artifact_registry" {
  source = "git::https://github.com/GCP-Terraform-Module-steamedEggMaster/artifact-registry-repository-module.git?ref=v1.0.0"

  repository_id = "example-repo"
  format        = "DOCKER"
  location      = "us-central1"
  labels        = {
    environment = "dev"
  }

  docker_config = {
    immutable_tags = true
  }

  vulnerability_scanning_config = {
    enablement_config = "ACTIVE"
  }
}
```

<br>

### 4. 출력값 (Outputs)

| 출력명             | 설명                                                                 |
|--------------------|----------------------------------------------------------------------|
| `id`              | Artifact Registry Repository의 ID                                    |
| `name`            | Artifact Registry Repository의 이름                                  |
| `format`          | Artifact Registry Repository의 포맷 (예: DOCKER, MAVEN, PYTHON)      |
| `location`        | Artifact Registry Repository의 지역                                  |
| `create_time`     | Artifact Registry Repository 생성 시간                               |
| `update_time`     | Artifact Registry Repository 업데이트 시간                           |
| `effective_labels`| Artifact Registry Repository의 최종 레이블                           |
| `uri`             | Artifact Registry Repository의 URI (참조용)                         |
| `project`         | Artifact Registry Repository가 속한 GCP 프로젝트 ID                 |
| `kms_key_name`    | Artifact Registry Repository에 사용된 KMS Key (Optional)            |

<br>

### 5. 지원 버전

#### a.  Terraform 버전
| 버전 범위 | 설명                              |
|-----------|-----------------------------------|
| `1.10.3`   | 최신 버전, 지원 및 테스트 완료                  |

#### b. Google Provider 버전
| 버전 범위 | 설명                              |
|-----------|-----------------------------------|
| `~> 6.0`  | 최소 지원 버전                   |

<br>

### 6. 모듈 개발 및 관리

- **저장소 구조**:
  ```
  artifact-registry-repository-module/
  ├── .github/workflows/  # github actions 자동화 테스트
  ├── examples/           # 테스트를 위한 루트 모듈 모음 디렉터리
  ├── test/               # 테스트 구성 디렉터리
  ├── main.tf             # 모듈의 핵심 구현
  ├── variables.tf        # 입력 변수 정의
  ├── outputs.tf          # 출력 정의
  ├── versions.tf         # 버전 정의
  ├── README.md           # 문서화 파일
  ```
<br>

---

## Terratest를 이용한 테스트
이 모듈을 테스트하려면 제공된 Go 기반 테스트 프레임워크를 사용하세요. 아래를 확인하세요:

1. Terraform 및 Go 설치.
2. 필요한 환경 변수 설정 (GCP_PROJECT_ID, API_SERVICES 등).
3. 테스트 실행:
```bash
go test -v ./test
```

<br>

## 주요 버전 관리
이 모듈은 [Semantic Versioning](https://semver.org/)을 따릅니다.  
안정된 버전을 사용하려면 `?ref=<version>`을 활용하세요:

```hcl
source = "git::https://github.com/GCP-Terraform-Module-steamedEggMaster/artifact-registry-repository-module.git?ref=v1.0.0"
```

### Module ref 버전
| Major | Minor | Patch |
|-----------|-----------|----------|
| `1.0.0`   |    |   |


<br>

## 기여 (Contributing)
기여를 환영합니다! 버그 제보 및 기능 요청은 GitHub Issues를 통해 제출해주세요.

<br>

## 라이선스 (License)
[MIT License](LICENSE)