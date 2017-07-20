# Copyright (c) 2017 PaddlePaddle Authors. All Rights Reserve.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

IF(NOT ${WITH_MKLML})
  return()
ENDIF(NOT ${WITH_MKLML})

INCLUDE(ExternalProject)

SET(MKLML_PROJECT       "extern_mklml")
SET(MKLML_VER           "mklml_lnx_2018.0.20170425")
SET(MKLML_URL           "https://github.com/01org/mkl-dnn/releases/download/v0.9/${MKLML_VER}.tgz")
SET(MKLML_DOWNLOAD_DIR  "${CMAKE_INSTALL_PREFIX}/opt/paddle/third_party/mklml")

SET(MKLML_ROOT          ${MKLML_DOWNLOAD_DIR}/${MKLML_VER})
SET(MKLML_INC_DIR       ${MKLML_ROOT}/include)
SET(MKLML_LIB_DIR       ${MKLML_ROOT}/lib)
SET(MKLML_LIB           ${MKLML_LIB_DIR}/libmklml_intel.so)
SET(MKLML_IOMP_LIB      ${MKLML_LIB_DIR}/libiomp5.so)
SET(CMAKE_INSTALL_RPATH    "${CMAKE_INSTALL_RPATH}" "${MKLML_ROOT}/lib")

INCLUDE_DIRECTORIES(${MKLML_INC_DIR})

ExternalProject_Add(
    ${MKLML_PROJECT}
    ${EXTERNAL_PROJECT_LOG_ARGS}
    PREFIX                ${MKLML_DOWNLOAD_DIR}
    DOWNLOAD_DIR          ${MKLML_DOWNLOAD_DIR}
    DOWNLOAD_COMMAND      wget --no-check-certificate -O ${MKLML_DOWNLOAD_DIR}/${MKLML_VER}.tgz ${MKLML_URL}
                          && tar -xzf ${MKLML_DOWNLOAD_DIR}/${MKLML_VER}.tgz
    DOWNLOAD_NO_PROGRESS  1
    UPDATE_COMMAND        ""
    PATCH_COMMAND         ""
    CONFIGURE_COMMAND     ""
    BUILD_COMMAND         ""
    INSTALL_COMMAND       ""
    TEST_COMMAND          ""
)

ADD_LIBRARY(mklml SHARED IMPORTED GLOBAL)
SET_PROPERTY(TARGET mklml PROPERTY IMPORTED_LOCATION ${MKLML_LIB})
ADD_DEPENDENCIES(mklml ${MKLML_PROJECT})
LIST(APPEND external_project_dependencies mklml)
