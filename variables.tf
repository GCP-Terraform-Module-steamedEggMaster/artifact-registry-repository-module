variable "repository_id" {
  description = "저장소 ID"
  type        = string
}

variable "format" {
  description = "저장소 포맷 (예: DOCKER, MAVEN, PYTHON)"
  type        = string
}

variable "description" {
  description = "저장소 설명 (Optional)"
  type        = string
  default     = null
}

variable "labels" {
  description = "저장소 사용자 정의 메타데이터 레이블 (Optional)"
  type        = map(string)
  default     = {}
}

variable "kms_key_name" {
  description = "고객 관리 암호화 키 (Optional)"
  type        = string
  default     = null
}

variable "location" {
  description = "저장소 위치 (Optional)"
  type        = string
  default     = null
}

variable "project" {
  description = "저장소가 속한 GCP 프로젝트 ID (Optional)"
  type        = string
  default     = null
}

variable "docker_config" {
  description = "Docker 저장소 설정 (Optional)"
  type = object({
    immutable_tags = optional(bool, false)
  })
  default = null
}

variable "maven_config" {
  description = "Maven 저장소 설정 (Optional)"
  type = object({
    allow_snapshot_overwrites = optional(bool, false)
    version_policy            = optional(string, "VERSION_POLICY_UNSPECIFIED")
  })
  default = null
}

variable "vulnerability_scanning_config" {
  description = "취약점 스캔 설정 (Optional)"
  type = object({
    enablement_config = optional(string, "INHERITED")
  })
  default = null
}

variable "timeout_create" {
  description = "생성 타임아웃 (Optional)"
  type        = string
  default     = "20m"
}

variable "timeout_update" {
  description = "업데이트 타임아웃 (Optional)"
  type        = string
  default     = "20m"
}

variable "timeout_delete" {
  description = "삭제 타임아웃 (Optional)"
  type        = string
  default     = "20m"
}