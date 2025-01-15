output "artifact_registry_repository_details" {
  description = "생성된 Artifact Registry Repository의 세부 정보"
  value = {
    id               = module.artifact_registry_repository.id               # Artifact Registry Repository의 ID
    name             = module.artifact_registry_repository.name             # Artifact Registry Repository의 이름
    format           = module.artifact_registry_repository.format           # Artifact Registry Repository의 포맷 (예: DOCKER, MAVEN, PYTHON)
    location         = module.artifact_registry_repository.location         # Artifact Registry Repository의 지역
    create_time      = module.artifact_registry_repository.create_time      # Artifact Registry Repository 생성 시간
    update_time      = module.artifact_registry_repository.update_time      # Artifact Registry Repository 업데이트 시간
    effective_labels = module.artifact_registry_repository.effective_labels # Artifact Registry Repository의 최종 레이블
    project_id       = module.artifact_registry_repository.project          # Artifact Registry Repository가 속한 GCP 프로젝트 ID
  }
}