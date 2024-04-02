variable "name" {
  type        = string
  description = "프로젝트 명을 작성합니다."
}

variable "type" {
  type        = string
  description = "사용하는 종류를 작성합니다. 종류에는 club(전공 동아리), school(학교 서비스), class(수업)가 있습니다."

  validation {
    condition     = contains(["club", "school", "class"], var.type)
    error_message = "종류는 club(전공 동아리), school(학교 서비스), class(수업) 중 하나여야 합니다."
  }
}
