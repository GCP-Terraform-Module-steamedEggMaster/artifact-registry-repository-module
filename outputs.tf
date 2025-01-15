output "id" {
  description = "Artifact Registry Repository의 ID"
  value       = google_artifact_registry_repository.artifact_repository.id
}

output "name" {
  description = "Artifact Registry Repository의 이름"
  value       = google_artifact_registry_repository.artifact_repository.name
}

output "format" {
  description = "Artifact Registry Repository의 포맷 (예: DOCKER, MAVEN, PYTHON)"
  value       = google_artifact_registry_repository.artifact_repository.format
}

output "location" {
  description = "Artifact Registry Repository의 지역"
  value       = google_artifact_registry_repository.artifact_repository.location
}

output "create_time" {
  description = "Artifact Registry Repository 생성 시간"
  value       = google_artifact_registry_repository.artifact_repository.create_time
}

output "update_time" {
  description = "Artifact Registry Repository 업데이트 시간"
  value       = google_artifact_registry_repository.artifact_repository.update_time
}

output "effective_labels" {
  description = "Artifact Registry Repository의 최종 레이블"
  value       = google_artifact_registry_repository.artifact_repository.effective_labels
}

output "uri" {
  description = "Artifact Registry Repository의 URI (참조용)"
  value       = "https://${google_artifact_registry_repository.artifact_repository.location}-docker.pkg.dev/${var.project}/${google_artifact_registry_repository.artifact_repository.name}"
}

output "project" {
  description = "Artifact Registry Repository가 속한 GCP 프로젝트 ID"
  value       = google_artifact_registry_repository.artifact_repository.project
}

output "kms_key_name" {
  description = "Artifact Registry Repository에 사용된 KMS Key (Optional)"
  value       = google_artifact_registry_repository.artifact_repository.kms_key_name
}
