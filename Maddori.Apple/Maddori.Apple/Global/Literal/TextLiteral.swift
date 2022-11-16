//
//  TextLiteral.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/14.
//

import UIKit

enum TextLiteral {
    
    // MARK: - Common
    
    static let doneButtonTitle = "입력완료"
    static let feedbackTypeLabel = "피드백 종류"
    static let feedbackKeywordLabel = "키워드"
    static let feedbackContentLabel = "내용"
    
    // MARK: - MainViewController
    
    static let mainViewControllerCurrentReflectionKeyword = "이번 회고에 담긴 피드백 키워드"
    static let mainViewControllerInvitationButtonText = "초대코드"
    static let mainViewControllerPlanLabelButtonSubText = "회고 일정이 없습니다"
    static let mainViewControllerPlanLabelButtonSubButtonText = "일정 만들기"
    static let mainViewControllerButtonText = "피드백 추가하기"
    
    // MARK: - AddFeedbackMemberViewController
    
    static let addFeedbackMemberViewControllerTitle = "피드백을 주고 싶은\n팀원을 선택해주세요"
    
    // MARK: - AddReflectionViewController
    
    static let addReflectionViewControllerTitle = "새로운 회고 정보를\n입력해주세요"
    static let addReflectionViewControllerName = "회고 이름"
    static let addReflectionViewControllerTextFieldPlaceHolder = "예) 1차 스프린트"
    static let addReflectionViewControllerDateLabel = "회고 일시"
    static let addReflectionViewControllerButtonText = "추가하기"
    
    // MARK: - SetupNicknameViewController
    
    static let setupNicknameViewControllerTitleLabel = "키고에서 사용할 \n닉네임을 입력해주세요"
    static let setupNicknameViewControllerNicknameTextFieldPlaceHolder = "예) 진저, 호야, 성민"
    
    // MARK: - AddFeedbackContentViewController
    
    static let addFeedbackContentViewControllerTitleLabel = "에게 피드백 보내기"
    static let addFeedbackContentViewControllerFeedbackKeywordTextFieldPlaceholder = "피드백을 키워드로 작성해주세요"
    static let addFeedbackContentViewControllerFeedbackContentTextViewPlaceholder = "키워드에 대한 자세한 내용을 작성해주세요"
    static let addFeedbackContentViewControllerDoneButtonTitle = "완료"
    static let addFeedbackContentViewControllerFeedbackStartLabel = "Start 제안하기"
    static let addFeedbackContentViewControllerStartTextViewPlaceholder = "제안하고 싶은 Start를 작성해주세요"
    static let addFeedbackContentViewControllerFeedbackSendTimeLabel = "작성한 피드백은 회고 시간 전까지 수정 가능합니다"
    
    // MARK: - JoinTeamViewController
    
    static let joinTeamViewControllerTitleLabel = "님 반가워요!\n이제 팀에 합류해주세요"
    static let joinTeamViewControllerNicknameTextFieldPlaceHolder = "초대코드"
    static let joinTeamViewControllerSubText = "팀이 없나요?"
    static let joinTeamViewControllerSubButtonText = "팀 생성하기"
    
    // MARK: - StartReflectionViewController
    
    static let startReflectionViewControllerStartTitle = "회고 시간이 되었습니다"
    static let startReflectionViewControllerStartText = "시작하기"
    
    // MARK: - CreateTeamViewController
    
    static let createTeamViewControllerTitleLabel = "팀 이름을 입력해주세요"
    static let createTeamViewControllerTextFieldPlaceHolder = "예) 맛쟁이 사과처럼"
    
    // MARK: - InvitedCodeViewController
    
    static let invitedCodeViewControllerTitleLabel = "초대코드를 공유하여\n팀원들을 초대해주세요"
    static let invitedCodeViewControllerCopyCodeButtonText = "코드 복사하기"
    static let invitedCodeViewControllerStartButtonText = "시작하기"
    static let invitedCodeViewControllerSubLabelText = "초대코드는 다시 복사할 수 있습니다."
    
    // MARK: - StartSuggestionView
    
    static let startSuggestionViewStartText = "⭐️ Start"
    
    // MARK: - SelectFeedbackMemberViewController
    
    static let selectFeedbackMemberViewControllerTitleLabel = "피드백을 듣고 싶은\n팀원을 선택해주세요"
    static let selectFeedbackMemberViewControllerDoneButtonText = "모든 회고 끝내기 "
    
    // MARK: - InProgressViewController
    
    static let InProgressViewControllerTitleLabel = "님의 회고 시간"
    static let InProgressViewControllerSubTitleLabel = "님은 이야기 나누고 싶은\n키워드를 선택해주세요"
    static let InProgressViewControllerOthersSubTitleLabel = "님이 선택한 키워드를 확인해주세요"
    static let InProgressViewControllerReceivedLabel = "내가 받은 피드백"
    static let InProgressViewControllerGivenLabel = "내가 보낸 피드백"
    static let InProgressViewControllerOtherGivenLabel = "팀원들이 보낸 피드백"
    
    // MARK: - MyReflectionViewHeader
    
    static let MyReflectionViewHeaderHeaderLabel = "모음집"
    
    // MARK: - EmptyFeedbackView
    
    static let emptyViewMyBox = "팀원에게 작성한 피드백이 없습니다\n홈에서 피드백을 작성해보세요"
    static let emptyViewMyReflection = "아직 진행한 회고가 없습니다\n회고를 완료하면 이곳에서 모아볼 수 있습니다"
    static let emptyViewInProgressMyRetrospective = "팀원에게 받은 피드백이 없습니다"
    static let emptyViewInProgressOthersRetrospectiveSelf = "내가 보낸 피드백이 없습니다"
    static let emptyViewInProgressOthersRetrospectiveOthers = "팀원들이 보낸 피드백이 없습니다"
    
    // MARK: - EmptyFeedbackKeyword
    
    static let emptyFeedbackKeywordLabel = "피드백"
    
    // MARK: - MyBoxViewController
    
    static let myBoxViewControllerTitleLabel = "내가 작성한 피드백"
    
    // MARK: - FeedbackFromMeDetailViewController
    
    static let feedbackFromMeDetailViewControllerDeleteButtonText: String = "삭제"
    static let feedbackFromMeDetailViewControllerTitleLabel: String = "님께 작성한 피드백"
    static let feedbackFromMeDetailViewControllerFeedbackStartLabel: String = "Start"
    static let feedbackFromMeDetailViewControllerEditButtonText: String = "수정하러 가기"
    static let feedbackFromMeDetailViewControllerReflectionIsStartedLabel: String = "회고가 시작되었습니다"
    static let feedbackFromMeDetailViewControllerBeforeReflectionLabel: String = "담아둔 피드백은 회고 시간 전까지 수정 가능합니다"
    
    // MARK: - AlertViewController
    
    static let alertViewControllerTypeDeleteTitle = "피드백 삭제하기"
    static let alertViewControllerTypeJoinTitle = "합류할 팀"
    static let alertViewControllerTypeDeleteSubTitle = "삭제된 피드백은 복구할 수 없습니다"
    static let alertViewControllerTypeJoinSubTitle = "팀에 합류하시겠어요?"
    static let alertViewControllerCancelButtonText = "취소"
    
    // MARK: - LoginViewController
    
    static let loginViewControllerLogoText: String = "KeyGo"
    static let loginViewControllerDescriptionText: String = "키워드로 회고하기"
    
    // MARK: - FeedbackToMeDetailViewController
    
    static let feedbackToMeDetailViewControllerFeedbackTypeLabel = "피드백 종류"
    static let feedbackToMeDetailViewControllerFeedbackFromLabel = "작성자"
    static let feedbackToMeDetailViewControllerFeedbackContentLabel = "내용"
    static let feedbackToMeDetailViewControllerFeedbackStartLabel = "Start"

    // MARK: - TabBar
    
    static let homeTabTitle: String = "홈"
    static let myboxTabTitle: String = "보관함"
    static let myReflectionTabTitle: String = "나의회고"
    
    // MARK: - ToastPopUpView
    
    static let warningText: String = "아직 회고 시간이 아닙니다"
    static let completeText: String = "초대코드가 복사되었습니다"
}
