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
    static let doneButtonNext = "다음"
    static let doneButtonComplete = "완료"
    
    // MARK: - MainViewController
    
    static let mainViewControllerCurrentReflectionKeyword = "이번 회고에 담긴 피드백 키워드"
    static let mainViewControllerInvitationButtonText = "초대코드"
    static let mainViewControllerPlanLabelButtonSubText = "회고 일정이 없습니다"
    static let mainViewControllerPlanLabelButtonSubButtonText = "일정 만들기"
    static let mainViewControllerButtonText = "피드백 추가하기"
    
    // MARK: - SelectFeedbackMemberViewController
    
    static let selectFeedbackMemberViewControllerTitle = "피드백을 주고 싶은\n팀원을 선택해주세요"
    
    // MARK: - CreateReflectionViewController
    
    static let createReflectionViewControllerTitle = "새로운 회고 정보를\n입력해주세요"
    static let createReflectionViewControllerName = "회고 이름"
    static let createReflectionViewControllerTextFieldPlaceHolder = "예) 1차 스프린트"
    static let createReflectionViewControllerDateLabel = "회고 일시"
    static let createReflectionViewControllerButtonText = "추가하기"
    
    // MARK: - SetNicknameViewController
    
    static let setNicknameViewControllerTitleLabel = "키고에서 사용할 \n닉네임을 입력해주세요"
    static let setNicknameViewControllerNicknameTextFieldPlaceHolder = "예) 진저, 호야, 성민"
    
    // MARK: - HomeViewController
    
    static let homeViewControllerEmptyDescriptionLabel = "아직 회고 일정이 정해지지 않았습니다"
    static let homeViewControllerCollectionViewEmtpyText0 = "첫 번째"
    static let homeViewControllerCollectionViewEmtpyText1 = "키워드를"
    static let homeViewControllerCollectionViewEmtpyText2 = "📝"
    static let homeViewControllerCollectionViewEmtpyText3 = "작성해보세요"
    static let homeViewControllerCollectionViewEmtpyText4 = "✚"
    
    // MARK: - AddFeedbackViewController
    
    static let addFeedbackViewControllerTitleLabel = "에게 피드백 주기"
    static let addFeedbackViewControllerFeedbackKeywordTextFieldPlaceholder = "피드백을 키워드로 작성해주세요"
    static let addFeedbackViewControllerFeedbackContentTextViewPlaceholder = "키워드에 대한 자세한 내용을 작성해주세요"
    static let addFeedbackViewControllerDoneButtonTitle = "완료"
    static let addFeedbackViewControllerFeedbackStartLabel = "Start 제안하기"
    static let addFeedbackViewControllerStartTextViewPlaceholder = "제안하고 싶은 Start를 작성해주세요"
    static let addFeedbackViewControllerFeedbackSendTimeLabel = "작성한 피드백은 회고 시간 전까지 수정 가능합니다"
    
    // MARK: - AddFeedbackContentViewController
    
    static let addFeedbackContentViewControllerCurrentStepLabel2 = "상황에 대한 설명과\n그 영향을 적어주세요"
    static let addFeedbackContentViewControllerCurrentStepLabel3 = "상황에 대해 느낀 점과\n그 이유를 적어주세요"
    static let addFeedbackContentViewControllerCurrentStepLabel4 = "상대방을 위한\n요청 또는 격려를 적어주세요"
    static let addFeedbackContentViewControllerCurrentStepDescriptionLabel2 = "ex. 제가 분위기를 파악 못하거나 눈치 채지 못해 잘못된 일을 했을 때 조용히 불러내서 알려줘서 고맙습니다."
    static let addFeedbackContentViewControllerCurrentStepDescriptionLabel3 = "ex. 정말로 몰랐던 일인데 덕분에 제 잘못을 알게 되고 고치게 되었어요. 다른 사람 앞에서 그런 얘기를 해주지 않아서 민망하지도 않았습니다."
    static let addFeedbackContentViewControllerCurrentStepDescriptionLabel4 = "ex. 앞으로도 이런 지적이라면 계속해주세요! 덕분에 항상 성장합니다"
    
    // MARK: - AddFeedbackKeywordViewController
    
    static let addFeedbackContentViewControllerCurrentStepLabel5 = "피드백을 대표하는\n키워드를 정해주세요"
    static let addFeedbackKeywordViewControllerPlaceholder = "키워드를 입력하세요"
    static let addFeedbackContentViewControllerToLabel = "피드백 줄 사람"
    static let addFeedbackContentViewControllerTypeLabel = "피드백 종류"
    static let addFeedbackContentViewControllerContentLabel = "피드백"
    
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
    
    // MARK: - InvitationCodeViewController
    
    static let invitationCodeViewControllerTitleLabel = "초대코드를 공유하여\n팀원들을 초대해주세요"
    static let invitationCodeViewControllerCopyCodeButtonText = "코드 복사하기"
    static let invitationCodeViewControllerStartButtonText = "시작하기"
    static let invitationCodeViewControllerSubLabelText = "초대코드는 다시 복사할 수 있습니다"
    
    // MARK: - StartSuggestionView
    
    static let startSuggestionViewStartText = "⭐️ Start"
    
    // MARK: - SelectReflectionMemberViewController
    
    static let selectReflectionMemberViewControllerTitleLabel = "각 팀원이 받은 피드백을\n공유해보세요"
    static let selectReflectionMemberViewControllerDoneButtonText = "모든 회고 끝내기"
    
    // MARK: - InProgressViewController
    
    static let inProgressViewControllerTitleLabel = "님의 회고 시간"
    static let inProgressViewControllerSubTitleLabel = "님은 이야기 나누고 싶은\n키워드를 선택해주세요"
    static let inProgressViewControllerOthersSubTitleLabel = "님이 선택한 키워드를 확인해주세요"
    static let inProgressViewControllerReceivedLabel = "내가 받은 피드백"
    static let inProgressViewControllerGivenLabel = "내가 보낸 피드백"
    static let inProgressViewControllerOtherGivenLabel = "팀원들이 보낸 피드백"
    
    // MARK: - MyReflectionCollectionViewHeader
    
    static let myReflectionCollectionViewHeaderHeaderLabel = "모음집"
    
    // MARK: - EmptyFeedbackView
    
    static let emptyViewMyBox = "팀원에게 작성한 피드백이 없습니다\n홈에서 피드백을 작성해보세요"
    static let emptyViewMyReflection = "아직 진행한 회고가 없습니다\n회고를 완료하면 이곳에서 모아볼 수 있습니다"
    static let emptyViewInProgressMyRetrospective = "팀원에게 받은 피드백이 없습니다"
    static let emptyViewInProgressOthersRetrospectiveSelf = "내가 보낸 피드백이 없습니다"
    static let emptyViewInProgressOthersRetrospectiveOthers = "팀원들이 보낸 피드백이 없습니다"
    static let emptyViewMyReflectionDetail = "팀원에게 받은 피드백이 없습니다"
    
    // MARK: - EmptyFeedbackKeyword
    
    static let emptyFeedbackKeywordLabel = "피드백"
    
    // MARK: - MyFeedbackViewController
    
    static let myFeedbackViewControllerTitleLabel = "내가 작성한 피드백"
    
    // MARK: - MyFeedbackDetailViewController
    
    static let myFeedbackDetailViewControllerDeleteButtonText: String = "삭제"
    static let myFeedbackDetailViewControllerTitleLabel: String = "에게 쓴 피드백"
    static let myFeedbackDetailViewControllerFeedbackStartLabel: String = "Start"
    static let myFeedbackDetailViewControllerEditButtonText: String = "수정하러 가기"
    static let myFeedbackDetailViewControllerReflectionIsStartedLabel: String = "회고가 시작되었습니다"
    static let myFeedbackDetailViewControllerBeforeReflectionLabel: String = "담아둔 피드백은 회고 시간 전까지 수정 가능합니다"
    static let myFeedbackDetailViewControllerBeforeReflectionLabelNotBefore: String = "회고가 시작되어 수정할 수 없습니다"
    
    // MARK: - AlertViewController
    
    static let alertViewControllerTypeDeleteTitle = "피드백 삭제하기"
    static let alertViewControllerTypeJoinTitle = "합류할 팀"
    static let alertViewControllerTypeDeleteSubTitle = "삭제된 피드백은 복구할 수 없습니다"
    static let alertViewControllerTypeJoinSubTitle = "팀에 합류하시겠어요?"
    static let alertViewControllerCancelButtonText = "취소"
    
    // MARK: - LoginViewController
    
    static let loginViewControllerLogoText: String = "KeyGo"
    static let loginViewControllerDescriptionText: String = "키워드로 회고하기"
    
    // MARK: - MyReflectionFeedbackViewController
    
    static let myReflectionFeedbackViewControllerFeedbackTypeLabel = "피드백 종류"
    static let myReflectionFeedbackViewControllerFeedbackFromLabel = "작성자"
    static let myReflectionFeedbackViewControllerFeedbackContentLabel = "내용"
    static let myReflectionFeedbackViewControllerFeedbackStartLabel = "Start"

    // MARK: - TabBar
    
    static let homeTabTitle: String = "홈"
    static let myFeedbackTabTitle: String = "보관함"
    static let myReflectionTabTitle: String = "나의회고"
    
    // MARK: - ToastPopUpView
    
    static let warningText: String = "아직 회고 시간이 아닙니다"
    static let completeText: String = "초대코드가 복사되었습니다"
    
    // MARK: - JoinReflectionButton
    
    static let joinReflectionButtonStatusText: String = "회고가 시작되었습니다!"
    static let joinReflectionTouchToEnterLabel: String = "터치하여 회고에 참여해주세요"
    
    // MARK: - MyReflectionViewController
    
    static let myReflectionViewControllerLogOutTitle: String = "로그아웃"
    static let myReflectionViewControllerLogOutMessage: String = "로그아웃 하시겠습니까?"
    static let myReflectionViewControllerDeleteUser: String = "회원탈퇴"
    static let myReflectionViewControllerDeleteUserAlertTitle: String = "회원탈퇴 하시겠습니까?"
    static let myReflectionViewControllerDeleteUserAlertMessage: String = "모든 회고와 피드백 정보가 사라지며, \n되돌릴 수 없습니다."
    static let myReflectionViewControllerDeleteUserTitle: String = "탈퇴한 멤버"
    
    // MARK: - FeedbackTypeButtonView
    
    static let feedbackTypeButtonViewContinueSubTitle: String = "지속해 주세요!"
    static let feedbackTypeButtonViewStopSubTitle: String = "그만해 주세요!"
    
    // MARK: - KeywordTextfield
    
    static let keywordLimitLabel: String = "키워드는 10글자 이내로 작성해주세요"
}
