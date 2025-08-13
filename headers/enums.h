#pragma once

#ifndef ENUMS_H
#define ENUMS_H

typedef enum _UNWIND_OP_CODES {
    UWOP_PUSH_NONVOL = 0, /* info == register number */
    UWOP_ALLOC_LARGE,     /* no info, alloc size in next 2 slots */
    UWOP_ALLOC_SMALL,     /* info == size of allocation / 8 - 1 */
    UWOP_SET_FPREG,       /* no info, FP = RSP + UNWIND_INFO.FPRegOffset*16 */
    UWOP_SAVE_NONVOL,     /* info == register number, offset in next slot */
    UWOP_SAVE_NONVOL_FAR, /* info == register number, offset in next 2 slots */
    UWOP_SAVE_XMM128 = 8, /* info == XMM reg number, offset in next slot */
    UWOP_SAVE_XMM128_FAR, /* info == XMM reg number, offset in next 2 slots */
    UWOP_PUSH_MACHFRAME   /* info == 0: no error-code, 1: error-code */
} UNWIND_CODE_OPS;

typedef enum _CUSTOM_FILE_INFO_CLASS
{
    //FileDirectoryInformation, // q: FILE_DIRECTORY_INFORMATION (requires FILE_LIST_DIRECTORY) (NtQueryDirectoryFile[Ex])
    CustomFileFullDirectoryInformation = 2, // q: FILE_FULL_DIR_INFORMATION (requires FILE_LIST_DIRECTORY) (NtQueryDirectoryFile[Ex])
    CustomFileBothDirectoryInformation, // q: FILE_BOTH_DIR_INFORMATION (requires FILE_LIST_DIRECTORY) (NtQueryDirectoryFile[Ex])
    CustomFileBasicInformation, // q; s: FILE_BASIC_INFORMATION (q: requires FILE_READ_ATTRIBUTES; s: requires FILE_WRITE_ATTRIBUTES)
    CustomFileStandardInformation, // q: FILE_STANDARD_INFORMATION, FILE_STANDARD_INFORMATION_EX
    CustomFileInternalInformation, // q: FILE_INTERNAL_INFORMATION
    CustomFileEaInformation, // q: FILE_EA_INFORMATION
    CustomFileAccessInformation, // q: FILE_ACCESS_INFORMATION
    CustomFileNameInformation, // q: FILE_NAME_INFORMATION
    CustomFileRenameInformation, // s: FILE_RENAME_INFORMATION (requires DELETE) // 10
    CustomFileLinkInformation, // s: FILE_LINK_INFORMATION
    CustomFileNamesInformation, // q: FILE_NAMES_INFORMATION (requires FILE_LIST_DIRECTORY) (NtQueryDirectoryFile[Ex])
    CustomFileDispositionInformation, // s: FILE_DISPOSITION_INFORMATION (requires DELETE)
    CustomFilePositionInformation, // q; s: FILE_POSITION_INFORMATION
    CustomFileFullEaInformation, // FILE_FULL_EA_INFORMATION
    CustomFileModeInformation, // q; s: FILE_MODE_INFORMATION
    CustomFileAlignmentInformation, // q: FILE_ALIGNMENT_INFORMATION
    CustomFileAllInformation, // q: FILE_ALL_INFORMATION (requires FILE_READ_ATTRIBUTES)
    CustomFileAllocationInformation, // s: FILE_ALLOCATION_INFORMATION (requires FILE_WRITE_DATA)
    CustomFileEndOfFileInformation, // s: FILE_END_OF_FILE_INFORMATION (requires FILE_WRITE_DATA) // 20
    CustomFileAlternateNameInformation, // q: FILE_NAME_INFORMATION
    CustomFileStreamInformation, // q: FILE_STREAM_INFORMATION
    CustomFilePipeInformation, // q; s: FILE_PIPE_INFORMATION (q: requires FILE_READ_ATTRIBUTES; s: requires FILE_WRITE_ATTRIBUTES)
    CustomFilePipeLocalInformation, // q: FILE_PIPE_LOCAL_INFORMATION (requires FILE_READ_ATTRIBUTES)
    CustomFilePipeRemoteInformation, // q; s: FILE_PIPE_REMOTE_INFORMATION (q: requires FILE_READ_ATTRIBUTES; s: requires FILE_WRITE_ATTRIBUTES)
    CustomFileMailslotQueryInformation, // q: FILE_MAILSLOT_QUERY_INFORMATION
    CustomFileMailslotSetInformation, // s: FILE_MAILSLOT_SET_INFORMATION
    CustomFileCompressionInformation, // q: FILE_COMPRESSION_INFORMATION
    CustomFileObjectIdInformation, // q: FILE_OBJECTID_INFORMATION (requires FILE_LIST_DIRECTORY) (NtQueryDirectoryFile[Ex])
    CustomFileCompletionInformation, // s: FILE_COMPLETION_INFORMATION // 30
    CustomFileMoveClusterInformation, // s: FILE_MOVE_CLUSTER_INFORMATION (requires FILE_WRITE_DATA)
    CustomFileQuotaInformation, // q: FILE_QUOTA_INFORMATION (requires FILE_LIST_DIRECTORY) (NtQueryDirectoryFile[Ex])
    CustomFileReparsePointInformation, // q: FILE_REPARSE_POINT_INFORMATION (requires FILE_LIST_DIRECTORY) (NtQueryDirectoryFile[Ex])
    CustomFileNetworkOpenInformation, // q: FILE_NETWORK_OPEN_INFORMATION (requires FILE_READ_ATTRIBUTES)
    CustomFileAttributeTagInformation, // q: FILE_ATTRIBUTE_TAG_INFORMATION (requires FILE_READ_ATTRIBUTES)
    CustomFileTrackingInformation, // s: FILE_TRACKING_INFORMATION (requires FILE_WRITE_DATA)
    CustomFileIdBothDirectoryInformation, // q: FILE_ID_BOTH_DIR_INFORMATION (requires FILE_LIST_DIRECTORY) (NtQueryDirectoryFile[Ex])
    CustomFileIdFullDirectoryInformation, // q: FILE_ID_FULL_DIR_INFORMATION (requires FILE_LIST_DIRECTORY) (NtQueryDirectoryFile[Ex])
    CustomFileValidDataLengthInformation, // s: FILE_VALID_DATA_LENGTH_INFORMATION (requires FILE_WRITE_DATA and/or SeManageVolumePrivilege)
    CustomFileShortNameInformation, // s: FILE_NAME_INFORMATION (requires DELETE) // 40
    CustomFileIoCompletionNotificationInformation, // q; s: FILE_IO_COMPLETION_NOTIFICATION_INFORMATION (q: requires FILE_READ_ATTRIBUTES) // since VISTA
    CustomFileIoStatusBlockRangeInformation, // s: FILE_IOSTATUSBLOCK_RANGE_INFORMATION (requires SeLockMemoryPrivilege)
    CustomFileIoPriorityHintInformation, // q; s: FILE_IO_PRIORITY_HINT_INFORMATION, FILE_IO_PRIORITY_HINT_INFORMATION_EX (q: requires FILE_READ_DATA)
    CustomFileSfioReserveInformation, // q; s: FILE_SFIO_RESERVE_INFORMATION (q: requires FILE_READ_DATA)
    CustomFileSfioVolumeInformation, // q: FILE_SFIO_VOLUME_INFORMATION (requires FILE_READ_ATTRIBUTES)
    CustomFileHardLinkInformation, // q: FILE_LINKS_INFORMATION
    CustomFileProcessIdsUsingFileInformation, // q: FILE_PROCESS_IDS_USING_FILE_INFORMATION (requires FILE_READ_ATTRIBUTES)
    CustomFileNormalizedNameInformation, // q: FILE_NAME_INFORMATION
    CustomFileNetworkPhysicalNameInformation, // q: FILE_NETWORK_PHYSICAL_NAME_INFORMATION
    CustomFileIdGlobalTxDirectoryInformation, // q: FILE_ID_GLOBAL_TX_DIR_INFORMATION (requires FILE_LIST_DIRECTORY) (NtQueryDirectoryFile[Ex]) // since WIN7 // 50
    CustomFileIsRemoteDeviceInformation, // q: FILE_IS_REMOTE_DEVICE_INFORMATION (requires FILE_READ_ATTRIBUTES)
    CustomFileUnusedInformation,
    CustomFileNumaNodeInformation, // q: FILE_NUMA_NODE_INFORMATION
    CustomFileStandardLinkInformation, // q: FILE_STANDARD_LINK_INFORMATION
    CustomFileRemoteProtocolInformation, // q: FILE_REMOTE_PROTOCOL_INFORMATION
    CustomFileRenameInformationBypassAccessCheck, // (kernel-mode only); s: FILE_RENAME_INFORMATION // since WIN8
    CustomFileLinkInformationBypassAccessCheck, // (kernel-mode only); s: FILE_LINK_INFORMATION
    CustomFileVolumeNameInformation, // q: FILE_VOLUME_NAME_INFORMATION
    CustomFileIdInformation, // q: FILE_ID_INFORMATION
    CustomFileIdExtdDirectoryInformation, // q: FILE_ID_EXTD_DIR_INFORMATION (requires FILE_LIST_DIRECTORY) (NtQueryDirectoryFile[Ex]) // 60
    CustomFileReplaceCompletionInformation, // s: FILE_COMPLETION_INFORMATION // since WINBLUE
    CustomFileHardLinkFullIdInformation, // q: FILE_LINK_ENTRY_FULL_ID_INFORMATION // FILE_LINKS_FULL_ID_INFORMATION
    CustomFileIdExtdBothDirectoryInformation, // q: FILE_ID_EXTD_BOTH_DIR_INFORMATION (requires FILE_LIST_DIRECTORY) (NtQueryDirectoryFile[Ex]) // since THRESHOLD
    CustomFileDispositionInformationEx, // s: FILE_DISPOSITION_INFO_EX (requires DELETE) // since REDSTONE
    CustomFileRenameInformationEx, // s: FILE_RENAME_INFORMATION_EX
    CustomFileRenameInformationExBypassAccessCheck, // (kernel-mode only); s: FILE_RENAME_INFORMATION_EX
    CustomFileDesiredStorageClassInformation, // q; s: FILE_DESIRED_STORAGE_CLASS_INFORMATION (q: requires FILE_READ_ATTRIBUTES; s: requires FILE_WRITE_ATTRIBUTES) // since REDSTONE2
    CustomFileStatInformation, // q: FILE_STAT_INFORMATION (requires FILE_READ_ATTRIBUTES)
    CustomFileMemoryPartitionInformation, // s: FILE_MEMORY_PARTITION_INFORMATION // since REDSTONE3
    CustomFileStatLxInformation, // q: FILE_STAT_LX_INFORMATION (requires FILE_READ_ATTRIBUTES and FILE_READ_EA) // since REDSTONE4 // 70
    CustomFileCaseSensitiveInformation, // q; s: FILE_CASE_SENSITIVE_INFORMATION (q: requires FILE_READ_ATTRIBUTES; s: requires FILE_WRITE_ATTRIBUTES)
    CustomFileLinkInformationEx, // s: FILE_LINK_INFORMATION_EX // since REDSTONE5
    CustomFileLinkInformationExBypassAccessCheck, // (kernel-mode only); s: FILE_LINK_INFORMATION_EX
    CustomFileStorageReserveIdInformation, // q; s: FILE_STORAGE_RESERVE_ID_INFORMATION (q: requires FILE_READ_ATTRIBUTES; s: requires FILE_WRITE_ATTRIBUTES)
    CustomFileCaseSensitiveInformationForceAccessCheck, // q; s: FILE_CASE_SENSITIVE_INFORMATION
    CustomFileKnownFolderInformation, // q; s: FILE_KNOWN_FOLDER_INFORMATION (q: requires FILE_READ_ATTRIBUTES; s: requires FILE_WRITE_ATTRIBUTES) // since WIN11
    CustomFileStatBasicInformation, // since 23H2
    CustomFileId64ExtdDirectoryInformation, // FILE_ID_64_EXTD_DIR_INFORMATION
    CustomFileId64ExtdBothDirectoryInformation, // FILE_ID_64_EXTD_BOTH_DIR_INFORMATION
    CustomFileIdAllExtdDirectoryInformation, // FILE_ID_ALL_EXTD_DIR_INFORMATION
    CustomFileIdAllExtdBothDirectoryInformation, // FILE_ID_ALL_EXTD_BOTH_DIR_INFORMATION
    FileStreamReservationInformation, // FILE_STREAM_RESERVATION_INFORMATION // since 24H2
    FileMupProviderInfo, // MUP_PROVIDER_INFORMATION
    CustomFileMaximumInformation
};

// Missing enum definitions
typedef enum _LDR_DLL_LOAD_REASON {
    LoadReasonStaticDependency = 0,
    LoadReasonStaticForwarderDependency,
    LoadReasonDynamicForwarderDependency,
    LoadReasonDelayloadDependency,
    LoadReasonDynamicLoad,
    LoadReasonAsImageLoad,
    LoadReasonAsDataLoad,
    LoadReasonUnknown = -1
} LDR_DLL_LOAD_REASON;

typedef enum _LDR_HOT_PATCH_STATE {
    LdrHotPatchBaseImage = 0,
    LdrHotPatchApplied,
    LdrHotPatchFailed
} LDR_HOT_PATCH_STATE;


typedef enum _NT_PRODUCT_TYPE {
    NtProductWinNt = 1,
    NtProductLanManNt,
    NtProductServer
} NT_PRODUCT_TYPE,
* PNT_PRODUCT_TYPE;

typedef enum _ALTERNATIVE_ARCHITECTURE_TYPE {
    StandardDesign,
    NEC98x86,
    EndAlternatives
} ALTERNATIVE_ARCHITECTURE_TYPE;


#endif