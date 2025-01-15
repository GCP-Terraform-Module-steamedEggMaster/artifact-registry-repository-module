resource "google_artifact_registry_repository" "artifact_repository" {
  # 필수 설정
  repository_id = var.repository_id # 저장소 ID
  format        = var.format        # 저장소 포맷 (예: DOCKER, MAVEN, PYTHON 등)

  # 선택적 설정
  description  = var.description  # 저장소 설명 (Optional)
  labels       = var.labels       # 사용자 정의 메타데이터 레이블 (Optional)
  kms_key_name = var.kms_key_name # 고객 관리 암호화 키 (Optional)
  location     = var.location     # 저장소 위치 (Optional)
  project      = var.project      # 저장소가 속한 GCP 프로젝트 ID (Optional)

  ### 저장소 포맷에 따라 선택해서 설정하면 됨
  # Docker 저장소 설정
  dynamic "docker_config" {
    for_each = var.docker_config != null ? [var.docker_config] : []
    content {
      immutable_tags = docker_config.value.immutable_tags # 태그 수정 방지 여부 (Optional)
    }
  }

  # Maven 저장소 설정
  dynamic "maven_config" {
    for_each = var.maven_config != null ? [var.maven_config] : []
    content {
      allow_snapshot_overwrites = maven_config.value.allow_snapshot_overwrites # Snapshot 덮어쓰기 허용 여부
      version_policy            = maven_config.value.version_policy            # 버전 정책 (Optional)
    }
  }

  # 취약점 스캔 설정
  dynamic "vulnerability_scanning_config" {
    for_each = var.vulnerability_scanning_config != null ? [var.vulnerability_scanning_config] : []
    content {
      enablement_config = vulnerability_scanning_config.value.enablement_config # 스캔 활성화 설정
    }
  }

  # 타임아웃 설정
  timeouts {
    create = var.timeout_create # 생성 타임아웃 (Optional)
    update = var.timeout_update # 업데이트 타임아웃 (Optional)
    delete = var.timeout_delete # 삭제 타임아웃 (Optional)
  }
}