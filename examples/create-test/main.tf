module "artifact_registry_repository" {
  source = "../../" # 모듈 경로를 설정

  # 필수 변수
  repository_id = "test-artifact-repo" # 저장소 ID
  format        = "DOCKER"             # 저장소 포맷 (예: DOCKER, MAVEN, PYTHON)

  # 선택적 변수
  description = "My Artifact Registry Repository" # 저장소 설명
  labels = {                                      # 사용자 정의 메타데이터 레이블
    environment = "test"
    team        = "devops"
  }

  location = "asia-northeast3" # 저장소 위치

  docker_config = {       # Docker 저장소 설정
    immutable_tags = true # 태그 수정 방지 여부
  }

  maven_config = {                        # Maven 저장소 설정
    allow_snapshot_overwrites = false     # Snapshot 덮어쓰기 비허용
    version_policy            = "RELEASE" # 버전 정책
  }

  vulnerability_scanning_config = { # 취약점 스캔 설정
    enablement_config = "ENABLED"   # 스캔 활성화
  }
}